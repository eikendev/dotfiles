<!--
Fill in the {{PLACEHOLDERS}} and send one filled copy per module, all in a single
message so the subagents run concurrently. Use subagent_type: general-purpose.
{{PRIMER_PATH}} = absolute path to github-markdown-primer.md. Normally
~/.claude/skills/book-to-notes/references/github-markdown-primer.md; for a handoff bundle
that ships without the skill, a local copy inside the bundle instead.
Delete this comment before sending.
-->
Convert one module of the {{BOOK_NAME}} PDF into a structured GitHub-flavored-markdown study note. The user owns this material; this is a legitimate reformatting task.

## Working directory
{{REPO_DIR}}

## Your module
- Module {{N}}: "{{MODULE_TITLE}}"
- Source PDF: {{PDF_FILENAME}}
- Pages (pass to pdftotext -f/-l): {{START}} to {{END}}
- Output file to CREATE: {{BOOK_DIR}}/modules/{{NN}}-{{slug}}.md

## Step 1 — Read the conventions (mandatory, first)
Read fully: STYLE.md, {{PRIMER_PATH}}, {{BOOK_DIR}}/README.md, and the pilot
module {{PILOT_MODULE_PATH}} — match that file's structure, voice, and verbatim-artifact
discipline as your template.

## Step 2 — Extract source text
Run `pdftotext -f {{START}} -l {{END}} {{PDF_FILENAME}} - 2>/dev/null`; also try `-layout`
for pages with code, tables, or register/crash dumps.

WATERMARK: dump one page first (`pdftotext -f {{START}} -l {{START}} {{PDF_FILENAME}} -`)
and identify the repeating footer/watermark lines. Strip them: {{WATERMARK_FOOTER_LINES}}.
If a diagonal watermark injects stray mid-text tokens ({{WATERMARK_TOKENS}}), drop them
and reconstruct the underlying word/sentence. NEVER let a stray token corrupt a command,
address, opcode, offset, or byte value. If a critical token is unavoidably garbled,
reconstruct from context and add `<!-- verify: watermark-garbled -->` next to it.

## Step 3 — Write the module (follow STYLE.md skeleton)
Module-specific focus:
{{FOCUS_BULLETS}}

General rules:
- Reshape prose (compress into tight statements, tables, checklists); preserve EVERY
  technical artifact verbatim (commands, addresses, offsets, assembly, byte values,
  register dumps, code). Keep long scripts/dumps in `<details>`.
- Redraw structural figures as mermaid or ASCII; do not write "[Figure N]".
- Use alerts sparingly (a few load-bearing, non-consecutive `> [!WARNING]`/`> [!TIP]`/
  `> [!IMPORTANT]`); at least one WARNING on the module's classic gotcha.
- End with a `## Cheat sheet` (the reusable commands/values for exam recall) and a
  `## Self-check` task list. Link back to the previous module and forward to the next.
- NO em dashes and no en-dash-as-punctuation (see STYLE.md). Write natural sentences;
  do not connect clauses with a dash.
- If the file has a `## Table of contents`, make sure every `[text](#slug)` link matches
  a heading's GitHub slug (lowercase, spaces->-, punctuation/backticks removed).

Write only that one file with the Write tool. Do NOT append anything after the last line
(no stray ``` fence, no closing tags).

## Step 4 — Report back
Concise summary: section headings produced, key artifacts preserved (the important
addresses/offsets/commands), anything reconstructed due to watermark garbling, and any
judgment calls. Do NOT paste the whole file back.
