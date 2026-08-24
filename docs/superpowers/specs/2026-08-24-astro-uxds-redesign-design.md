# Design: Rebuild kennethho.ca on Astro UXDS Web Components

**Date:** 2026-08-24
**Status:** Approved for planning
**Author:** Kenneth Ho (with Claude)

## Summary

Replace the Hugo + Blowfish static-site setup with a hand-authored, single-page
site built from [Astro UXDS](https://www.astrouxds.com/) Web Components. The goal
is to **remove the build toolchain and the upstream theme dependency**, keep the
existing linktree content and visual identity, and end up with a site that
renders with **zero external runtime dependencies**.

"Astro UXDS" here means Rocket Communications' *Astro Space UX Design System*
(`@astrouxds/astro-web-components`) — a framework-agnostic Web Component library
and design-token set. It is **not** the Astro build framework (astro.build), which
is not used.

## Goals

- Drop Hugo, Dart Sass, the Blowfish theme submodule, and every build step.
- Keep the site's content and look: dark, LCARS space backdrop, profile,
  social links, one project card.
- Restyle everything with Astro UXDS components and design tokens for a
  mission-control aesthetic consistent with the design system.
- Dark mode only — no light theme.
- Page renders with **no external requests** (JS, CSS, and fonts all vendored
  locally). Analytics (Umami) is the sole external tag and is explicitly
  non-critical.
- Show a **SECRET** classification banner only on the `staging` deployment,
  stamped per-branch by CI.
- Improve repo readability: all website source under `src/`.

## Non-goals

- No blog, no multi-page site, no CMS. It stays a single landing page.
- No light/theme-switching support.
- No change to hosting, domains, DNS, or the branch→environment mapping.
- No local build step (no bundler, no `npm ci` in CI).

## Decisions (locked)

1. **Delivery: fully vendored ("Option A").** The Astro UXDS JS bundle, CSS, and
   Roboto fonts are downloaded once at a pinned version and committed under
   `src/vendor/`. No CDN, no npm install, no build. Rendering depends on nothing
   external.
2. **Visual direction: Astro components over the LCARS backdrop.** Keep the
   existing `lcars0` space image as the page background; build all UI (cards,
   buttons, banner) from Astro UXDS components and tokens.
3. **SECRET banner: stamped per-branch by CI.** CI marks the deployed files as
   `staging` or `production`; CSS reveals the banner only when marked `staging`.
   (Chosen over runtime hostname detection so the banner tracks the branch, not
   the URL.)
4. **Umami analytics: kept, non-critical.** Rendering must not depend on it; it
   may fail or be blocked with no visible effect.

## Architecture

### Repository layout (target)

```
src/
  index.html              # the entire site — one page
  styles/
    site.css              # layout, LCARS backdrop, banner reveal rule (uses Astro tokens)
    fonts.css             # @font-face declarations pointing at local Roboto
  vendor/astro/           # upstream-generated, committed, never hand-edited
    astro-web-components.esm.js
    astro-web-components.css
    <lazy-loaded chunk files>
    fonts/roboto-*.woff2
  img/                    # avatar, LCARS backdrop, favicons, webmanifest
  CNAME                   # kennethho.ca (GitHub Pages custom domain)
docs/                     # authoring docs (unchanged location)
README.md
.github/workflows/deploy.yml
```

**Removed:** `themes/` and `.gitmodules` (Blowfish submodule), `config/`,
`content/`, `layouts/`, `archetypes/`, `resources/`, `public/`, `static/`
(contents move to `src/img/`), `.hugo_build.lock`, `.hugo-server.log`.

### The page (`src/index.html`)

Content parity with the current site:

- **Profile block:** avatar `kenough-400x400.webp`, name "Kenneth Ho", headline
  "Cloud Systems Administrator | DevOps Analyst · 10+ yrs keeping mission-critical
  systems running."
- **Social links:** GitHub (`https://github.com/im-kenough`) and LinkedIn
  (`https://www.linkedin.com/in/kenneth-yyz`) as `<rux-button>` elements with
  icons.
- **Personal Projects:** a `<rux-card>` for DineSafeViz — description text, four
  tech tags (Terraform, Ansible, Docker, PostgreSQL), and a "View on GitHub"
  `<rux-button>` → `https://github.com/im-kenough/DineSafeViz`.
- **Backdrop:** `lcars0-1377x1080.webp` as a fixed, cover-sized page background;
  Astro components sit on top.
- **Head:** title, description meta, favicons/manifest, canonical link, the
  vendored CSS + font CSS, the non-critical Umami tag, and the vendored ESM
  module (`type="module"`, self-registering the custom elements).

### Vendored library

Downloaded from the published `@astrouxds/astro-web-components` package at a
pinned version:

- `astro-web-components.css` — base styles + design tokens (dark by default).
- `astro-web-components.esm.js` + its lazy-loaded chunk files — self-registers
  the `rux-*` custom elements when loaded as a module.
- Roboto `.woff2` for weights **300, 400, 500, 700**, referenced by
  `src/styles/fonts.css` (replacing the design system's default Google Fonts
  link so nothing is fetched externally).

The pinned version is recorded in `README.md`. Updating = replace the folder with
a newer release and bump the noted version. The folder is labelled as generated /
do-not-edit.

### SECRET banner (per-branch stamp)

- `src/index.html` ships with `<html lang="en" data-env="production">` and
  contains the banner markup up front:
  `<rux-classification-marking classification="secret"></rux-classification-marking>`
  (banner is the component's default form) at the top and bottom of the page, per
  the classification-markings guidance.
- `src/styles/site.css` hides the banners by default and reveals them only under
  `:root[data-env="staging"]`.
- **CI stamp:** the staging deploy job rewrites `data-env="production"` →
  `data-env="staging"` in `src/index.html` before upload. The production deploy
  leaves it as `production`. This is a text substitution at deploy time, not a
  build.

### CI/CD (`.github/workflows/deploy.yml`)

The `build` job is removed entirely. Triggers, permissions, and per-branch
concurrency are unchanged.

- **Production (`main`):** checkout → write `CNAME` (kennethho.ca) → stamp
  `data-env="production"` → upload `src/` as the Pages artifact → `deploy-pages`
  to GitHub Pages.
- **Staging (`staging`):** checkout → stamp `data-env="staging"` → deploy `src/`
  to Cloudflare Pages via `wrangler-action` (`--project-name=kennethho-stg
  --branch=staging`).

No Hugo, no Dart Sass, no `npm ci`, no submodule checkout. Same branches, same
hosts, same URLs.

### Docs & README

- `docs/ref/ci-cd.md`: rewrite the build and flow sections (drop Hugo, update the
  mermaid diagram to show "upload `src/`" instead of "build with Hugo").
- `README.md`: new tech-stack section (Web Components + vendored Astro UXDS, no
  SSG), note the pinned library version and how to update it.
- `docs/tools.md`, `docs/how-to/**`: unchanged.

## Verification

- Serve `src/` locally and load the page **with network access blocked**; it must
  render fully (proves zero external render dependencies).
- With `data-env="staging"`: top and bottom SECRET banners visible. With
  `data-env="production"`: no banners anywhere in the rendered page.
- Visual parity check against the current live site (profile, links, project
  card, LCARS backdrop).
- Confirm the deploy workflow YAML is valid and the two deploy paths reference the
  correct hosts/projects.

## Risks & trade-offs

- **Vendored file sprawl:** the lazy-loading bundle is ~dozens of small files.
  Accepted as the cost of full self-containment; quarantined under
  `src/vendor/astro/` and never hand-edited.
- **Manual library updates:** no Dependabot on the submodule anymore. Mitigated
  by recording the pinned version and keeping updates to a folder swap; a
  Dependabot/script automation can be added later if desired.
- **Component API drift:** `rux-*` attributes are pinned to the vendored version,
  so upstream changes cannot silently break the page.
