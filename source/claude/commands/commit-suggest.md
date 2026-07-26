---
description: Suggest 5 Conventional Commit messages from staged changes
context: fork
agent: plan
---

# Suggest commit messages

Propose Conventional Commit messages based **only** on the currently staged git changes.

Do not infer or assume anything from prior conversation context, unstaged changes, or untracked files. The staged diff is the single authoritative source.

## Repository context

Branch and status:
!`git status -sb`

Recent commits (match their style, scope vocabulary, and casing):
!`git log -n 10 --pretty=format:'%h %s'`

Staged files:
!`git diff --staged --name-only`

Staged diff (authoritative source):
!`git diff --staged`

## Commit message specification

This specification is authoritative. Every suggestion MUST comply with it. Reuse scopes already established in the recent commits above. The key words MUST, MUST NOT, SHOULD, SHOULD NOT, MAY, and OPTIONAL are interpreted as described in RFC 2119.

### Message structure

A commit message MUST be structured as follows:

```
<type>[optional scope][optional !]: <description>

[optional body]

[optional footer(s)]
```

- The first line is the **subject line**.
- The body and footer sections are OPTIONAL but, if present, MUST be separated by a single blank line.

### Subject line rules

- MUST NOT exceed 50 characters.
- MUST use the imperative, present tense.
- MUST NOT be capitalized.
- MUST NOT end with punctuation.
- MUST describe *what the change does*, not *how*.

### Type

Each commit MUST start with exactly one type token. The following types are ALLOWED and RECOMMENDED:

- `feat`: introduces new or changed functionality visible to users or consumers
- `fix`: patches a bug or incorrect behavior
- `perf`: improves performance without changing externally observable behavior
- `refactor`: restructures code without changing functionality or performance intent
- `style`: formatting or stylistic changes only; no behavior change
- `test`: adds or corrects tests only
- `docs`: documentation-only changes
- `build`: changes to build tools, packaging, or release configuration
- `ci`: CI/CD pipelines, automation, and workflow orchestration
- `chore`: maintenance or non-feature work that does not fit other types

Types other than `feat` and `fix` have no implied semantic-versioning effect unless marked as breaking.

#### Type selection decision rules

Choose exactly one type using this ordered checklist:

1. If the change fixes a bug or a security issue → `fix`
2. Else if it introduces or changes user-visible functionality, API, UI, or a new security feature → `feat`
3. Else if it is explicitly performance-focused → `perf`
4. Else if it restructures code without behavior or performance change → `refactor`
5. Else if it only changes formatting or style → `style`
6. Else if it only adds or updates tests → `test`
7. Else if it only changes documentation → `docs`
8. Else if it affects build tooling, packaging, dependencies, or versioning → `build`
9. Else if it affects CI/CD pipelines or automation → `ci`
10. Else → `chore`

`chore` MUST be treated as a last-resort fallback to avoid semantic dilution.

### Scope

- A scope MAY be provided to clarify the affected subsystem.
- A scope MUST be a short noun wrapped in parentheses, e.g. `feat(api): add pagination support`.
- Issue identifiers MUST NOT be used as scopes.

### Breaking changes

A breaking change MUST be indicated in one of the following ways:

- By appending `!` immediately before the colon in the subject line, e.g. `refactor(api)!: ...`.
- By adding a `BREAKING CHANGE:` footer (MUST be uppercase, format `BREAKING CHANGE: <description>`).

If `!` is used, the footer MAY be omitted.

### Description

- REQUIRED. MUST immediately follow the colon and space. MUST be concise and precise.

### Body and footers

- The body MAY explain motivation, context, or contrast with prior behavior. It MUST start after a blank line, SHOULD wrap at 72 characters, and MUST use the imperative, present tense.
- Footers MAY follow the body, separated by a blank line, and MUST follow git trailer conventions (`<Token>: <value>`, tokens hyphenated except `BREAKING CHANGE`), e.g. `Closes: #123`.

### Versioning semantics

When used with Semantic Versioning: `fix` → PATCH, `feat` → MINOR, any commit with a breaking change → MAJOR.

### Security-related changes

- Security fixes that patch a vulnerability or incorrect behavior MUST use `fix`.
- New security mechanisms, controls, or protections MUST use `feat`.
- Security-related changes MUST NOT introduce a dedicated security-specific type.

### Additional rules

- Commits that logically span multiple types SHOULD be split into multiple commits.
- Case sensitivity is ignored by tooling, except for `BREAKING CHANGE`.
- Revert commits SHOULD follow git defaults and MAY use the `revert` type.

## Task

1. If there are no staged changes, say so and stop — do not suggest anything.
2. Read the staged diff and determine what the changes actually do.
3. Pick the type, scope, and breaking-change flag that fit the change, preferring scopes and conventions seen in the recent commits.
4. Draft ~10 candidate messages internally, then select the best 5 distinct options (no duplicates, no near-duplicates).
5. Output to the user exactly the 5 enumerated options and nothing else.

## Output format

```
1. feat: add JWT login and refresh token flow
2. feat(auth): implement JWT middleware and auth routes
3. feat(api): add authentication endpoints with JWT support
4. refactor(auth)!: restructure auth flow around JWT tokens
5. feat(auth): support refresh tokens and add auth tests
```
