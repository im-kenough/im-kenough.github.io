# Releases

Releases are cut by pushing a version tag. A GitHub Actions workflow then
drafts a GitHub Release whose notes are generated automatically from the pull
requests merged since the previous tag. This page is the reference for what the
tags mean and how pull requests map to release-note sections. For the
step-by-step process, see
[`../how-to/operations/create-release.md`](../how-to/operations/create-release.md).

## Version tags

Tags follow [Semantic Versioning](https://semver.org/): `vMAJOR.MINOR.PATCH`,
always prefixed with `v`. The workflow triggers on any tag matching `v*`.

| Segment | Example bump      | Meaning                                            |
| ------- | ----------------- | -------------------------------------------------- |
| MAJOR   | `v1.4.0` → `v2.0.0` | Incompatible or ground-up change to the site, such as a redesign or a change that breaks existing links or embeds. |
| MINOR   | `v1.4.0` → `v1.5.0` | New content or features added in a backward-compatible way. |
| PATCH   | `v1.4.1` → `v1.4.2` | Fixes and small tweaks with no new features, such as copy edits, styling fixes, or dependency bumps. |

The site is a personal landing page, so most releases are MINOR or PATCH. The
previous released tags are `v1.0.0` and `v1.1.0`.

## How notes are generated

The workflow runs `gh release create --generate-notes`, which asks the GitHub
API to build a "What's Changed" list from every pull request merged since the
previous tag. Each entry links the pull request and credits its author. No
build step or third-party action is involved.

Grouping into sections is controlled by
[`../../.github/release.yml`](../../.github/release.yml). Labels are aligned
with [Conventional Commit](https://www.conventionalcommits.org/) types, plus a
`security` label. Each merged pull request is placed in the first section whose
labels it matches, so order matters: a pull request labeled both `security` and
`fix` lands under **Security**.

| Section            | Pull request labels        |
| ------------------ | -------------------------- |
| 🔒 Security        | `security`                 |
| 🚀 Features        | `feat`                     |
| 🐛 Fixes           | `fix`                      |
| ⚡ Performance     | `perf`                     |
| 🎨 UI & Styling    | `ui`, `style`              |
| 📝 Documentation   | `docs`                     |
| ♻️ Refactoring     | `refactor`                 |
| 🧰 CI/CD & Build   | `ci`, `build`              |
| ⬆️ Dependencies    | `dependencies`             |
| 🧹 Chores          | `chore`, `test`, `revert`  |
| 📦 Other Changes   | any other label (catch-all) |

Two labels are special:

- `skip-changelog` excludes a pull request from the notes entirely. Use it for
  changes that don't belong in a release, such as internal doc tweaks.
- The `"*"` catch-all under **Other Changes** means an unlabeled pull request
  still appears in the notes, so nothing is silently dropped. Labeling is what
  sorts a pull request into a nicer section; it never decides whether the
  change is listed.

Because sections are driven by labels, notes only categorize pull requests that
carry labels. Historical pull requests merged before this workflow existed are
mostly unlabeled and appear under **Other Changes** if included in a range.

## Pull requests with multiple labels

A pull request is listed once, under the first section in the table above whose
labels it matches, and it is never duplicated across sections. Because the table
order sets precedence, a pull request labeled both `security` and `fix` appears
only under **Security**. The `skip-changelog` exclusion is the exception: it
drops the pull request entirely, regardless of any other label it carries.

## Draft, not published

The workflow creates the release as a **draft**. A draft is visible only to
repository collaborators and is not tagged as the latest release until a human
publishes it. This leaves the final review and the Publish action to you. See
the how-to for that step.

## Related

- Create a release: [`../how-to/operations/create-release.md`](../how-to/operations/create-release.md)
- Config: [`../../.github/release.yml`](../../.github/release.yml)
- Workflow: [`../../.github/workflows/release.yml`](../../.github/workflows/release.yml)
- CI/CD strategy: [`ci-cd.md`](ci-cd.md)
