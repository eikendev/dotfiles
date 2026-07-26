# <Repo> Style Guide

<!-- Starter style guide for a book-to-notes repo. Adapt the audience note and the
     examples to your subject, then keep it as the single source of truth at the repo
     root. Every module and every subagent follows this file. -->

How every study note in this repo is written. The goal is a **GitHub-rendered,
navigable, engineer-grade study reference**, not a transcript of the source PDF.
We *reshape* material we already own into something faster to study and revise from.

> [!NOTE]
> Audience baseline: <state the reader's existing knowledge>. **Skip the absolute
> basics.** Teach what is actually new or hard, not what the reader already knows.

---

## 1. One file per module

- Each book gets a top-level directory (e.g. `BOOK-ID/`).
- Each module/chapter is one file in `modules/NN-slug.md`, numbered to match the
  source chapter.
- The book `README.md` is the landing page: module index table + progress
  tracker + legend.

## 2. Every module file follows this skeleton

```markdown
# NN · <Module Title>

> One-paragraph "what this module teaches and why it matters" abstract.

**Source:** <BOOK>, pp. <start>–<end>
**Prereqs:** [link to modules this builds on](./NN-...md)

## Table of contents      <!-- only if the file is long -->

## Key concepts           <!-- crisp definitions, tables -->
## <Section per major topic>
   ### Walkthrough / procedure
   ### Gotchas
## Cheat sheet             <!-- the commands/values you'll want at recall time -->
## Self-check              <!-- task-list of "can I do X from memory?" -->
## References
```

Not every section is mandatory, but **Cheat sheet** and **Self-check** are. They
are what makes these notes better than the PDF.

## 3. Reshape, don't transcribe

- **Compress prose ruthlessly.** Turn multi-sentence explanations into tight
  statements, tables, or bullet lists.
- **Preserve every technical artifact verbatim and exactly:** commands, syntax,
  code, addresses, offsets, byte values, output dumps. Copy-paste correct. Do not
  paraphrase a command.
- Convert step-by-step procedures into **numbered checklists**.

## 4. GitHub Flavored Markdown we use

- **Fenced code with language tags** (` ```python `, ` ```bash `, ` ```text `, …).
- **Tables** for reference data (parameters, values, comparisons).
- **Alerts**, used *sparingly* (1–2 per file max): `> [!TIP]`, `> [!WARNING]`,
  `> [!IMPORTANT]`. Pick the one that fits; do not stack them.
- **Collapsible `<details>`** for long dumps, full scripts, and self-check answers.
- **Task lists** for the Self-check section.
- **Footnotes** for citations / external links.
- **Mermaid** (` ```mermaid `) to redraw diagrams the book shows as figures.
- **Math** (`$...$` / `$$...$$`) only where a real formula helps.
- **Relative links** between modules: `[title](./NN-...md)`.

## 5. Figures

Don't embed the PDF's raster figures. Redraw structural figures as Mermaid or ASCII,
transcribe tool-output screenshots into a `text` code block, and drop decorative ones.

## 6. Tone

Direct, technical, second-person imperative for procedures. No marketing voice, no
"in this section we will". Get to the point.

**No em dashes (`—`), and no en dashes (`–`) as sentence punctuation.** They read
unnaturally here. Write plain sentences instead: split a long clause into two
sentences, use a comma or parentheses for an aside, or use a colon to introduce a
list or explanation. Do not "fix" an em dash by swapping in another single symbol;
rewrite the sentence so it never needed one. En dashes stay only in numeric ranges
(`pp. 88–134`, address ranges like `10000000–10223000`), where they're correct.
