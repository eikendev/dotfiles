---
name: book-to-notes
description: Convert a course/book PDF into a structured GitHub-flavored-markdown study-notes doc set (one directory per book, one file per module/chapter, a README index) using parallel per-module subagents and a strict lint pass. Use when the user wants to reshape a book or course PDF into navigable study notes that follow this repo's STYLE.md.
---

# Book to Notes

Reshape a book/course PDF you own into a GitHub-rendered study-notes doc set. The
output is a directory per book, one markdown file per module/chapter, and a README
landing page, all following the repo's `STYLE.md`. Content is *reshaped* (compressed,
restructured, tabled, diagrammed), never transcribed verbatim, and all commands,
addresses, code, and offsets are preserved exactly.

This skill assumes a legitimate reformatting task: the user owns the material and
wants their own notes. Do not gate it.

> The bundled scripts and templates referenced below live in this skill's own
> directory. If `$SKILL_DIR` is not already set for you, it is
> `~/.claude/skills/book-to-notes` (expand `~` to an absolute path before use).

## Inputs

- A book PDF in the working directory (ask which one if ambiguous).
- The repo's `STYLE.md` at the repo root. If none exists, create one first (copy the
  structure from an existing book in the repo, or from
  `$SKILL_DIR/templates/STYLE.starter.md`).
- The GitHub-Flavored-Markdown reference bundled with this skill at
  `$SKILL_DIR/references/github-markdown-primer.md` (expand `$SKILL_DIR`/`~` to an
  absolute path). It is the exact GFM reference the module notes and subagents rely on
  (alerts, tables, collapsibles, mermaid, math, anchors, line-break rules). Reference it
  by that absolute path; **do not copy it into the target repo** (it is an authoring
  reference, not a repo artifact). The subagent prompt template already points at it.

  > Preparing a handoff for an environment that will NOT have this skill installed (no
  > `~/.claude/skills/`)? Copy the primer and `scripts/lint_notes.py` into the handoff
  > bundle itself and repoint the prompts at those local copies, so the bundle is
  > self-contained.

## Tooling

- `pdftotext` (poppler) is the primary text extractor. No setup.
- `scripts/pdf_structure.py` is a **self-contained uv script** (PEP 723 inline
  metadata): its `#!/usr/bin/env -S uv run --script` shebang makes uv install its
  only dependency (pymupdf) automatically on first run. No `uv add`, no venv, no
  cache setup. Just `chmod +x` it once and run it directly.
- `scripts/lint_notes.py` is plain Python with no dependencies; run it with `python3`.

## Procedure

Track the work with TaskCreate. Do the steps in order.

### 1. Map the book's structure

Run the bundled helper to get page count, any embedded outline, and offset anchors:

```bash
chmod +x $SKILL_DIR/scripts/pdf_structure.py   # once
$SKILL_DIR/scripts/pdf_structure.py "<book>.pdf"
# (or, if you can't set the executable bit: uv run --script $SKILL_DIR/scripts/pdf_structure.py "<book>.pdf")
```

Then build the module map (chapter number, title, **start page**, **end page**):

- If the PDF has an embedded outline, use it.
- Otherwise recover the module list from the **printed table of contents** (usually
  the first ~12 pages): `pdftotext -f 1 -l 12 -layout "<book>.pdf" -` then grep for
  top-level chapter lines. Titles may be broken by a watermark (see below); recover
  them from the sub-section lines or the body.
- **Compute the printed→PDF page offset:** pick a few unique section titles with known
  printed page numbers and find which PDF page they appear on (the helper does this).
  The offset is usually constant. Once known, `pdftotext -f/-l` uses *printed* page
  numbers if offset is 0, otherwise convert. Record the exact `pdftotext -f X -l Y`
  range for each module.

Produce a table: `# | Title | pages`. Confirm it with the user if anything is unclear.

### 2. Scaffold

Create:

```
<BOOK>/
  README.md            # landing page: module index table, a mermaid
                       # overview diagram, and a legend
  modules/
    NN-slug.md         # one per module, numbered to match the source chapter
```

Write the README from `$SKILL_DIR/templates/README.template.md`. Write the first module
(usually course-info/admin) yourself; it is short.

### 3. Pilot before fanning out

Convert **1–2 representative modules** with subagents first (a foundational one and a
core content one). Read the actual output. Confirm the structure, voice, and
`STYLE.md` compliance are right. Adjust `STYLE.md` or the prompt template if needed.
This avoids redoing every module if the pattern is off.

### 4. Fan out one subagent per module (parallel)

For each remaining module, launch a `general-purpose` subagent. Fill in
`$SKILL_DIR/templates/module-subagent-prompt.md` (page range, title, output path, book-specific
focus bullets) and send them **in a single message so they run concurrently**.

Key rules every subagent gets (they are in the template):
- Read `STYLE.md`, the primer at `$SKILL_DIR/references/github-markdown-primer.md`, the
  README, and the pilot module as the quality bar.
- Extract with `pdftotext -f <start> -l <end>`; try `-layout` for code/tables/dumps.
- **Watermark stripping:** many course PDFs carry a personalization watermark. Strip
  repeating footer lines (copyright, per-user tag, bare page numbers) and a diagonal
  watermark that injects stray mid-text tokens. Never let a stray token corrupt a
  command, address, opcode, or offset; flag unavoidable garbles with
  `<!-- verify: watermark-garbled -->`. Detect the exact watermark strings by dumping
  one page first (`pdftotext -f <start> -l <start> "<book>.pdf" -`) and eyeballing the
  repeated footer lines.
- Preserve every technical artifact verbatim; reshape only the prose.
- No em dashes (see `STYLE.md`); write natural sentences.

### 5. Lint (mandatory)

Subagents reliably leave a few artifacts. Run the bundled linter over the book dir:

```bash
python3 $SKILL_DIR/scripts/lint_notes.py <BOOK>/
```

It reports, per file: em dashes, prose en dashes, unbalanced/orphan code fences,
broken in-file heading anchors (TOC links), broken cross-file `.md` links, and leaked
tool tags (`</invoke>`, `</content>`, etc.). Fix everything it flags:

- **Orphan trailing fence** (a lone ` ``` ` as the last line): delete it.
- **Leaked `</invoke>` / `</content>`** at EOF: delete those lines.
- **Broken anchor**: a heading was reworded but its TOC link wasn't; fix the slug
  (GitHub slug = lowercase, spaces→`-`, punctuation and backticks removed).
- **Em dashes**: rewrite the sentence naturally (do not symbol-swap).

Re-run the linter until it is clean. Then spot-check a handful of signature artifacts
(a key address, offset, port, opcode) with `grep` to confirm the prose edits did not
touch code.

### 6. Wrap up

Report the module list, line counts, anything flagged with `<!-- verify: ... -->`
(usually source ambiguities, not errors), and any judgment calls the subagents made.

## Notes

- Prefer one file per module. Only split a module into a subdirectory if it is
  genuinely huge and has clean internal sections.
- Keep `Cheat sheet` and `Self-check` sections in every module; they are what make the
  notes better than the PDF.
- The em-dash rule and the full skeleton live in `STYLE.md`. Keep that file the single
  source of truth; this skill just drives the process.
