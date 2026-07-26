#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["pymupdf"]
# ///
"""Discover a book PDF's structure and compute the printed->PDF page offset.

Self-contained uv script (PEP 723): uv reads the inline metadata above and installs
pymupdf into an isolated env automatically on first run. No `uv add`, no venv, no cache
setup needed. Make it executable once (`chmod +x pdf_structure.py`) and run it directly.

Usage:
    # 1) Overview: page count, embedded outline (if any), candidate chapter lines
    ./pdf_structure.py "<book>.pdf"

    # 2) Compute the printed->PDF offset from anchors you read off the printed TOC.
    #    Give "text@printedpage" pairs; the script finds which PDF page each lands on.
    #    Use BODY section titles (not chapter titles that also appear on a divider),
    #    and pick phrases unlikely to repeat. The finder skips the front matter/TOC.
    ./pdf_structure.py "<book>.pdf" \
        "Introduction to x86 Architecture@21" "Creating Custom Shellcode@233"
    #    Override where the body starts (default 12) if the TOC is longer:
    ./pdf_structure.py "<book>.pdf" --from 20 "Some Section@140"

    # If the executable bit isn't set, run it through uv instead:
    #    uv run --script pdf_structure.py "<book>.pdf"

If offset is 0 you can pass printed page numbers straight to `pdftotext -f/-l`.
Otherwise: pdftotext_page = printed_page + offset.
"""
import sys
import re

import fitz  # pymupdf, provided by the inline script metadata above


def overview(doc):
    print(f"pages: {doc.page_count}")
    toc = doc.get_toc()
    if toc:
        print(f"\nembedded outline: {len(toc)} entries")
        for lvl, title, page in toc:
            print(f"{'  ' * (lvl - 1)}[p{page:>4}] {title}")
    else:
        print("\nembedded outline: NONE (recover from the printed TOC below)")
        print("\ncandidate TOC lines (number ... printed-page) from the first 14 pages.")
        print("Watermarks may corrupt titles; cross-check against the body:")
        seen = set()
        for i in range(min(14, doc.page_count)):
            for line in doc[i].get_text().splitlines():
                # any line with a leading number, a dot-leader run, then a trailing page number
                m = re.match(r"^\s*(\d{1,2}(?:\.\d+)*)\s+(.*?)\.{3,}\s*(\d{1,3})\s*$", line)
                if not m:
                    continue
                num, title, pg = m.group(1), m.group(2).strip(), m.group(3)
                key = (num, pg)
                if key in seen:
                    continue
                seen.add(key)
                depth = num.count(".")
                print(f"  {'  ' * depth}{num:<7} p{pg:>4}  {title[:60]}")
        if not seen:
            print("  (none matched — dump the printed TOC directly with:"
                  " pdftotext -f 1 -l 14 -layout \"<book>.pdf\" - )")


def find_offset(doc, anchors, body_start=12):
    print(f"(skipping the first {body_start} pages as front matter/TOC)")
    print("printed  anchor                                  -> PDFidx  pdftotext_pg  offset")
    offsets = []
    for spec in anchors:
        text, _, printed = spec.rpartition("@")
        printed = int(printed)
        hits = [i for i in range(doc.page_count) if text in doc[i].get_text()]
        body_hits = [i for i in hits if i >= body_start]
        if not hits:
            print(f"{printed:>7}  {text[:40]:<40} -> NOT FOUND")
            continue
        hit = body_hits[0] if body_hits else hits[0]
        # pdftotext is 1-indexed: pdftotext_pg = hit + 1 ; offset in that space:
        pdftotext_pg = hit + 1
        off = pdftotext_pg - printed
        offsets.append(off)
        extra = ""
        if len(hits) > 1:
            extra = f"   (also on PDFidx {[h for h in hits if h != hit][:4]}; used first body hit)"
        print(f"{printed:>7}  {text[:40]:<40} -> {hit:>6}  {pdftotext_pg:>11}  {off:+d}{extra}")
    if offsets:
        if len(set(offsets)) == 1:
            off = offsets[0]
            print(f"\nCONSISTENT offset = {off:+d}.  "
                  f"pdftotext_page = printed_page + ({off:+d}).")
            if off == 0:
                print("=> printed page numbers can be passed straight to `pdftotext -f/-l`.")
        else:
            print(f"\nWARNING: inconsistent offsets {offsets} — front matter may be paginated oddly; "
                  f"use per-region offsets.")


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(2)
    args = sys.argv[2:]
    body_start = 12
    if "--from" in args:
        idx = args.index("--from")
        body_start = int(args[idx + 1])
        del args[idx:idx + 2]
    doc = fitz.open(sys.argv[1])
    if args:
        find_offset(doc, args, body_start=body_start)
    else:
        overview(doc)


if __name__ == "__main__":
    main()
