# Markdown on GitHub — A Primer

A quick reference to what **GitHub Flavored Markdown (GFM)** adds on top of "basic"
(CommonMark / classic Daring-Fireball) Markdown. This document assumes you already
know standard Markdown and only documents the deltas.

---

## What works exactly as usual

These behave the way they do in any Markdown flavor — no notes needed:

- **Headings** — `#` through `######` (one to six).
- **Bold / italic** — `**bold**` / `__bold__`, `*italic*` / `_italic_`, and `***both***`.
- **Blockquotes** — lines prefixed with `>`.
- **Inline code** — single backticks; **code blocks** — triple backticks (fenced).
- **Links** — `[text](url)`; **images** — `![alt](url)`.
- **Lists** — unordered (`-`, `*`, `+`), ordered (`1.`), and nested via indentation.
- **Paragraphs** — separated by a blank line.
- **Escaping** — backslash before a Markdown character (`\*`, `\#`, …).
- **Horizontal rules**, **HTML passthrough** (a safe subset), etc.

Everything below is where GitHub differs or adds features.

---

## 1. Tables *(GFM extension — not in basic Markdown)*

Built with pipes `|` and hyphens `-`. A blank line **must** precede the table.

```markdown
| First Header | Second Header |
| ------------ | ------------- |
| Content Cell | Content Cell  |
```

- Outer pipes are optional; cells need not be visually aligned.
- Each header separator needs **at least three hyphens**.
- **Alignment** via colons in the separator row: `:---` (left), `:---:` (center), `---:` (right).
- Inline formatting (links, `code`, **bold**, *italic*) works inside cells.
- To put a literal pipe in a cell, escape it: `\|`.

---

## 2. Task lists *(GFM extension)*

```markdown
- [x] Completed item
- [ ] Open item
- [ ] Closes #739     <!-- issue/PR numbers auto-expand to titles -->
```

- `[ ]` = unchecked, `[x]` = checked. Must follow a `-`/`*`/`+` list marker + space.
- If the text after the checkbox starts with `(`, escape it: `- [ ] \(Optional) …`.

---

## 3. Strikethrough *(GFM extension)*

```markdown
~~mistaken text~~      (also single-tilde: ~mistaken~)
```

---

## 4. Alerts / callouts / admonitions *(GitHub-specific)*

A blockquote whose first line is a bracketed keyword. Rendered with a colored
icon and border. **Five types only:**

```markdown
> [!NOTE]
> Useful information the reader should know.

> [!TIP]
> Helpful advice for doing things better.

> [!IMPORTANT]
> Key info needed to succeed.

> [!WARNING]
> Urgent — needs immediate attention.

> [!CAUTION]
> Warns about risks or negative outcomes.
```

Rules: keyword must be exactly one of the five, uppercase. Don't nest alerts,
don't stack them consecutively, and use sparingly (1–2 per document).

---

## 5. Footnotes *(GitHub extension)*

```markdown
Here is a claim.[^1]

[^1]: The supporting reference.
```

- Reference with `[^label]`; define anywhere with `[^label]: text`.
- Placement of the definition doesn't matter — footnotes always render at the
  bottom. Multi-line footnotes: indent continuation lines.
- **Not supported in wikis.**

---

## 6. Emoji shortcodes *(GitHub extension)*

```markdown
:tada: :+1: :shipit: :rocket:
```

Type `:` in the GitHub UI to autocomplete. Full list: the
[Emoji-Cheat-Sheet](https://github.com/ikatyang/emoji-cheat-sheet).

---

## 7. Mentions & references *(GitHub-specific autolinking)*

- `@username` / `@org/team-name` — notifies the person/team.
- `#123` — links to issue/PR number `123` (autocompletes when you type `#`).
- Bare URLs are auto-linked (no `[]()` needed).
- Commit SHAs and configured **custom autolinks** (e.g. `JIRA-123`) also convert
  to links. These mostly matter in issues/PRs/discussions, not always in `.md`.

---

## 8. Math — LaTeX via MathJax *(GitHub extension)*

- **Inline:** `$ … $` or, when the expression clashes with Markdown, `` $` … `$ ``.
- **Block:** wrap in `$$ … $$`, or use a fenced ` ```math ` block (no `$$` needed).

```markdown
Inline: $\sqrt{3x-1}+(1+x)^2$

$$\left( \sum_{k=1}^n a_k b_k \right)^2 \leq \left( \sum a_k^2 \right)\left( \sum b_k^2 \right)$$
```

- Literal `$` inside math: escape as `\$`. Literal `$` on the same line as math
  but outside it: wrap in `<span>$</span>`.

---

## 9. Diagrams from fenced code blocks *(GitHub-specific)*

Use a fenced block with a special language identifier. Four syntaxes supported:

- ` ```mermaid ` — flowcharts, sequence, pie, etc. (Mermaid). Use ` ```mermaid `
  containing `info` to print the supported Mermaid version.
- ` ```geojson ` / ` ```topojson ` — interactive maps.
- ` ```stl ` — ASCII STL 3D models.

```markdown
```mermaid
graph TD;
    A-->B;
    A-->C;
```​
```

Available in issues, discussions, PRs, wikis, and `.md` files.

---

## 10. Collapsed / expandable sections *(HTML, GitHub-rendered)*

```markdown
<details>
<summary>Click to expand</summary>

Any Markdown goes here — headers, code blocks, images.
(Leave a blank line after </summary> so inner Markdown renders.)

</details>
```

Add the `open` attribute (`<details open>`) to render expanded by default.

---

## 11. Color chips *(GitHub-specific)*

A supported color model inside backticks renders a small color swatch —
**only in issues, PRs, and discussions** (not `.md` files):

```markdown
`#0969DA`   `rgb(9, 105, 218)`   `hsl(212, 92%, 45%)`
```

No leading/trailing spaces inside the backticks.

---

## 12. Subscript, superscript, underline *(via HTML tags)*

Basic Markdown has no syntax for these; GitHub supports the HTML:

```markdown
H<sub>2</sub>O    x<sup>2</sup>    <ins>underlined</ins>
```

---

## 13. Syntax highlighting *(GFM extension)*

Add a language identifier after the opening fence:

````markdown
```ruby
puts "Hello World"
```
````

Detection/grammars via [Linguist](https://github.com/github-linguist/linguist).
Use lowercase identifiers for GitHub Pages/Jekyll. To show literal triple
backticks, wrap the block in **quadruple** backticks.

---

## 14. Headings: auto-anchors & table of contents *(GitHub behavior)*

- With ≥2 headings, GitHub auto-generates an **"Outline" table of contents**.
- Every heading gets an automatic anchor. Slug rules: lowercase → spaces become
  `-` → other punctuation removed → duplicates get `-1`, `-2`, … suffixes.
  Link with `[text](#heading-slug)`.
- **Custom anchors:** `<a name="my-anchor"></a>`, linked via `[text](#my-anchor)`.
  Custom anchors do **not** appear in the outline/TOC.

---

## 15. Relative links & images *(GitHub behavior)*

Relative paths resolve against the current file and current branch
automatically (`./`, `../`, and leading `/` = repo root all work). Prefer
relative links over absolute so they survive clones and branch switches. The
`<picture>` element is also supported for responsive/light-dark images.

---

## 16. Line breaks — a key GitHub gotcha

- **In issues, PRs, and discussions:** a single newline **already** renders as a
  line break (soft breaks are honored).
- **In `.md` files:** a single newline does **not** break the line (standard
  Markdown). To force a break, end the line with **two spaces**, a **backslash
  `\`**, or `<br/>`.

---

## 17. Hiding content *(GitHub behavior)*

Anything inside an HTML comment is omitted from the rendered output:

```markdown
<!-- This will not appear when rendered -->
```
