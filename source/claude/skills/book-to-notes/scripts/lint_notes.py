#!/usr/bin/env python3
"""Lint a book's study-notes directory for the issues per-module subagents leave behind.

Usage:
    python lint_notes.py <BOOK_DIR> [--style path/to/STYLE.md]

Checks, per markdown file:
  - em dashes (—) anywhere            (the repo forbids these in prose)
  - en dashes (–) used as prose punctuation (ranges like `0x00`–`0xFF` are ignored)
  - unbalanced / orphan code fences   (a missing close, or a lone trailing ```)
  - leaked tool tags (</invoke>, </content>, <parameter …>, etc.)
  - broken in-file heading anchors    (TOC links [x](#slug) with no matching heading)
  - broken cross-file relative .md links

Exit code is non-zero if any problem is found, so it can gate a loop.
"""
import re
import sys
import os
import glob

EM = "—"   # —
EN = "–"   # –
TAG_RE = re.compile(r"</?(?:invoke|content|antml:\w+|parameter|function_calls)\b")


def gh_slug(text: str) -> str:
    """Approximate GitHub's heading-anchor slug algorithm."""
    s = text.strip().lower()
    s = re.sub(r"[^\w\s-]", "", s, flags=re.UNICODE)  # drop punctuation, backticks, ·, #, :, etc.
    s = s.replace(" ", "-")
    return s


def iter_fence_state(lines):
    """Yield (lineno, line, in_fence) where in_fence is True for lines INSIDE a code block."""
    in_fence = False
    for i, l in enumerate(lines, 1):
        if l.lstrip().startswith("```"):
            yield i, l, in_fence  # the fence marker itself reported with pre-toggle state
            in_fence = not in_fence
        else:
            yield i, l, in_fence


def check_file(path):
    problems = []
    lines = open(path, encoding="utf-8").read().splitlines()

    # --- fences ---
    fence_lines = [i for i, l in enumerate(lines, 1) if l.lstrip().startswith("```")]
    if len(fence_lines) % 2 != 0:
        last = fence_lines[-1]
        problems.append((last, "fence", f"odd number of code fences ({len(fence_lines)}); "
                                        f"likely a missing close or an orphan fence near line {last}"))
        if lines and lines[-1].strip() == "```":
            problems.append((len(lines), "fence", "file ends with a lone ``` (orphan trailing fence — delete it)"))

    # --- headings + anchors + content checks (skip inside code fences) ---
    slugs = {}
    for lineno, l, in_fence in iter_fence_state(lines):
        if in_fence:
            continue
        m = re.match(r"^(#{1,6})\s+(.*\S)\s*$", l)
        if m:
            base = gh_slug(m.group(2))
            n = slugs.get(base, 0)
            slugs[base] = n + 1
    valid = set()
    for base, count in slugs.items():
        for k in range(count):
            valid.add(base if k == 0 else f"{base}-{k}")

    in_fence = False
    for lineno, l in enumerate(lines, 1):
        if l.lstrip().startswith("```"):
            in_fence = not in_fence
            continue
        # tool tags anywhere
        if TAG_RE.search(l):
            problems.append((lineno, "tool-tag", f"leaked tool tag: {l.strip()[:60]!r}"))
        if in_fence:
            continue
        # em dashes
        if EM in l:
            problems.append((lineno, "em-dash", l.strip()[:90]))
        # prose en dashes: flag an en dash that is NOT a range between word/paren chars
        for mm in re.finditer(EN, l):
            seg = l[max(0, mm.start() - 2):mm.start() + 3]
            if not re.search(r"[\w`)]\s?" + EN + r"\s?[\w`(]", seg):
                problems.append((lineno, "en-dash?", l.strip()[:90]))
        # in-file anchors
        for anchor in re.findall(r"\]\(#([^)]+)\)", l):
            if anchor not in valid:
                problems.append((lineno, "anchor", f"#{anchor} has no matching heading"))

    # --- cross-file relative .md links ---
    base_dir = os.path.dirname(path)
    in_fence = False
    for lineno, l in enumerate(lines, 1):
        if l.lstrip().startswith("```"):
            in_fence = not in_fence
            continue
        for link in re.findall(r"\]\((\.{1,2}/[^)#]+\.md)", l):
            target = os.path.normpath(os.path.join(base_dir, link))
            if not os.path.isfile(target):
                problems.append((lineno, "link", f"missing target: {link}"))

    return problems


def main():
    args = sys.argv[1:]
    if not args:
        print(__doc__)
        sys.exit(2)
    book_dir = args[0]
    md_files = sorted(glob.glob(os.path.join(book_dir, "**", "*.md"), recursive=True))
    if "--style" in args:
        md_files.append(args[args.index("--style") + 1])
    if not md_files:
        print(f"No markdown files under {book_dir}")
        sys.exit(2)

    total = 0
    for f in md_files:
        probs = check_file(f)
        # em dashes inside backtick spans (documentation of the character) are false positives;
        # keep them visible but they are usually only in STYLE.md.
        if probs:
            print(f"\n=== {f} ===")
            for lineno, kind, msg in probs:
                print(f"  L{lineno:<4} [{kind}] {msg}")
            total += len(probs)

    print(f"\n{'CLEAN' if total == 0 else f'{total} problem(s) found'} "
          f"across {len(md_files)} file(s).")
    sys.exit(0 if total == 0 else 1)


if __name__ == "__main__":
    main()
