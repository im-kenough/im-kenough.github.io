# Create a release

This guide walks through cutting a release. You label the merged pull requests,
push a version tag, and let GitHub Actions draft a GitHub Release with notes
generated from those pull requests. You then review the draft and publish it.
For what the tags mean and how labels map to note sections, see
[`../../ref/release.md`](../../ref/release.md).

## Before you start

- Decide the new version from the changes since the last release. Releases
  follow `vMAJOR.MINOR.PATCH`. See
  [version tags](../../ref/release.md#version-tags) if you're unsure which
  segment to bump.
- The release notes are only as tidy as your labels. Label pull requests as you
  merge them, or add labels afterward before tagging.

## Label the pull requests

Notes are grouped by pull request label. Labels follow
[Conventional Commit](https://www.conventionalcommits.org/) types, plus a
`security` label. Apply one of the recognized labels to each pull request that
will be part of the release:

- `security` for security fixes and hardening.
- `feat` for new content or features.
- `fix` for bug fixes.
- `perf` for performance improvements.
- `ui` or `style` for visual, layout, or styling changes.
- `docs` for documentation changes.
- `refactor` for restructuring that doesn't change behavior.
- `ci` or `build` for pipeline and tooling changes.
- `dependencies` for dependency updates (Dependabot applies this
  automatically).
- `chore`, `test`, or `revert` for other maintenance.
- `skip-changelog` to keep a pull request out of the notes entirely.

A pull request lands in the section of its first matching label, so `security`
takes precedence over the others. An unlabeled pull request still appears under
**Other Changes**, so labeling is about tidiness, not inclusion.

<!-- prettier-ignore -->
> [!TIP]
> You can add labels to an already-merged pull request. Open the pull request
> and set the labels in the sidebar before you tag.

## Tag and push

From the repository root, with `main` checked out and up to date:

1. Confirm you're on the commit you want to release:

   ```bash
   git checkout main
   git pull
   ```

2. Create an annotated tag for the new version. Replace `v1.2.0` with your
   version:

   ```bash
   git tag -a v1.2.0 -m "v1.2.0"
   ```

3. Push the tag:

   ```bash
   git push origin v1.2.0
   ```

Pushing a tag that matches `v*` triggers the `draft release` workflow in
[`../../../.github/workflows/release.yml`](../../../.github/workflows/release.yml).

<!-- prettier-ignore -->
> [!NOTE]
> If you tagged the wrong commit, delete the tag locally and remotely
> (`git tag -d v1.2.0` and `git push origin :refs/tags/v1.2.0`), then delete the
> draft release from the **Releases** page and start over.

## Review and publish the draft

The workflow creates the release as a **draft**, so nothing is public yet.

1. Go to the repository's **Releases** page on GitHub. The new draft appears at
   the top, named after your tag.
2. Click the draft, then **Edit** to review the generated notes. Check that
   entries landed in the right sections and fix any wording.
3. When the notes look right, click **Publish release**.

The published release is public and marked as the latest release.

## Re-running without a new tag

If a draft failed to generate or you deleted it, you can re-run the workflow
against an existing tag without creating a new one:

1. On GitHub, go to **Actions**, then the **draft release** workflow.
2. Click **Run workflow**, enter the tag (for example, `v1.2.0`), and run it.

This uses the workflow's `workflow_dispatch` input to draft the release for a
tag that already exists.

## Related

- Release reference: [`../../ref/release.md`](../../ref/release.md)
- CI/CD strategy: [`../../ref/ci-cd.md`](../../ref/ci-cd.md)
- Workflow: [`../../../.github/workflows/release.yml`](../../../.github/workflows/release.yml)
