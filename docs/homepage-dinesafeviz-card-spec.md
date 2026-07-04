# Homepage DineSafeViz Card Spec

Instructions for an LLM coding agent to add a single **DineSafeViz project card** to the
[`kennethho.ca`](https://kennethho.ca) homepage. This is a [Hugo](https://gohugo.io/) site
using the [Blowfish](https://blowfish.page/) theme, deployed to GitHub Pages via GitHub
Actions.

> This is the medium-term follow-on to `docs/homepage-mvp-spec.md`. The MVP made the page
> *point* at DineSafeViz (a header menu link). This spec makes the page *sell* it: a small,
> deliberate card that says what the project is in one line, shows the stack, and links out.
> **A link is a promise** — the card is the promise the resume and LinkedIn are making when
> they say "portfolio project." Keep it minimal. One card, done well, beats a busy page.

## Goal

A reader who lands on the homepage should, within ~10 seconds:
1. See who this is and what they do (already handled by the profile block / MVP spec).
2. See **one project card** with the DineSafeViz one-liner, 2–4 tech tags, and a clear
   link out to the project hub.
3. See nothing broken, cramped, or placeholder — the card should look like a designed
   component, not an afterthought.

## Current state (verified against the repo)

- `config/_default/params.toml`: `[homepage] layout = "background"`. **The `background`
  layout renders no page body** — only the background image plus the header menu. So a
  card authored as page content will not appear until the homepage layout is switched to
  one that renders `.Content` (see P0.1). Both the `profile` and `card` home partials
  render `<section class="prose">{{ .Content }}</section>`, i.e. they output the body of
  `content/_index.md` — verified in `themes/blowfish/layouts/partials/home/profile.html`
  and `.../card.html`.
- `config/_default/menus.en.toml`: header already has **LinkedIn**, **GitHub**, and a
  **DineSafeViz** menu item (weight 30) pointing at the repo, with a `TODO` to swap to the
  live URL. The menu link stays; the card is a *separate, richer* element in the page body.
- `content/_index.md`: exists, currently only an HTML-comment `TODO` for an experience
  highlights block. This is where the card content goes.
- `config/_default/markup.toml`: `[goldmark.renderer] unsafe = true` — **raw HTML and
  shortcodes in `_index.md` will render.** The card can be hand-rolled HTML.
- `config/_default/params.toml` already sets `[params.author] headline` and the
  `img/kenough.jpeg` avatar exists — the profile layout has everything it needs.
- Blowfish ships `{{< badge >}}` and `{{< button >}}` shortcodes
  (`themes/blowfish/layouts/shortcodes/`). **Do not use the `{{< article >}}` shortcode for
  this** — it resolves an *internal* page by `RelPermalink` and cannot render a card for an
  external URL like `dinesafeviz.com`.

## Canonical copy (reuse verbatim — do not rewrite)

The DineSafeViz description is fixed across resume, LinkedIn, and the README so the reader
hears the same sentence everywhere. Source: `jh-2026/to-do/funnel-map.md` and
`to-do/linkedin-dinesafeviz-project.md`.

- **Card heading:** `DineSafeViz`
- **One-liner (verbatim):**
  > A containerized web app that visualizes 26 years of Toronto Public Health DineSafe
  > food-inspection data.
- **Optional second line (only if the card doesn't look sparse):**
  > Provisioned as code with Terraform, Packer, and Ansible; migrating to Azure Kubernetes
  > Service (AKS).
- **Tech tags (pick 3–4, most relevant first):** `Terraform` · `Ansible` · `Docker` ·
  `PostgreSQL` · `Grafana`. Keep it to a handful — tags are a signal, not an inventory.
- **House style:** Canadian spelling, **no em dashes** (use commas, semicolons, or "and").

## Link target (important)

- **Right now:** point the card's link at the repo — `https://github.com/im-kenough/DineSafeViz`.
- **Once `dinesafeviz.com` resolves:** switch the card link to `https://dinesafeviz.com`
  (the project hub). Leave a `<!-- TODO: swap to https://dinesafeviz.com once it resolves -->`
  marker next to the URL, matching the existing marker in `menus.en.toml`. Do **not** point
  the homepage at the repo *and* the domain yet — one link now; the two-link version
  (repo + live app) is a later step once AKS is live.
- External link hygiene: `target="_blank"` plus `rel="noopener noreferrer"`.

## Quality bar — good web design (apply to every change)

- **One card, centered, constrained width.** Roughly `max-w-md`/`max-w-lg`; a full-bleed
  card on a wide screen looks broken. It should feel like a deliberate component.
- **Clear visual hierarchy:** heading (bold) → one-line description (muted, smaller) →
  tag row → link/button. Consistent internal padding; don't crowd the edges.
- **Breathing room.** Separate the card from the profile block above it with real vertical
  space (e.g. `mt-8`/`mt-10`), so it reads as its own section.
- **Responsive.** Full-width within its container on mobile, constrained on desktop; tags
  wrap gracefully and never overflow. Verify at a narrow viewport.
- **Contrast in both appearances.** `defaultAppearance = "dark"`; the card, text, tags, and
  link must all be legible in dark *and* light. Use the theme's `dark:` variants, not
  hard-coded colours.
- **Accessible & semantic.** The link is a real `<a>` with descriptive text (e.g.
  "View DineSafeViz on GitHub" / "Visit DineSafeViz"), not "click here". Hover/focus states
  are visible and keyboard-navigable.
- **Uses the theme, not a bespoke stylesheet.** Prefer Blowfish/Tailwind utility classes
  and the `{{< badge >}}`/`{{< button >}}` shortcodes over new CSS. If the card sits inside
  Blowfish's `prose` wrapper and prose styling fights the layout, wrap it in `not-prose`.
- **No placeholder / no "Coming soon"** on the card. If the live URL isn't ready, the card
  simply links to the repo — that is not a placeholder, it's the current promise.

## Privacy constraints (carry over from the MVP spec — hard requirements)

- No phone number, no personal email anywhere on the page.
- No resume PDF hosted on the site.
- If any analytics/verification IDs are touched, confirm they're meant to be public; never
  commit secrets.

---

## P0 — Must do

### P0.1 — Make the homepage render a page body
The card lives in `content/_index.md`, but the current `background` layout won't render it.
Switch the homepage to a layout that outputs `.Content`.

- **Recommended: `profile`** (`[homepage] layout = "profile"` in `params.toml`). Matches
  `homepage-mvp-spec.md` Option A: avatar + name + headline + social links, with the card
  rendered as the body directly beneath. Everything it needs (`img/kenough.jpeg`,
  `headline`, `author.links`) is already configured.
- If the owner has already chosen a layout while implementing the MVP spec, **respect that
  choice** and just ensure it renders `.Content` (both `profile` and `card` do). Do not
  silently revert an earlier decision — if the current layout is `background` by intent,
  raise it as a `[validate]` issue rather than switching unilaterally.

### P0.2 — Author the DineSafeViz card in `content/_index.md`
Add the card to the page body using the canonical copy above. Recommended structure — a
self-contained HTML card (raw HTML is enabled) using Blowfish/Tailwind classes, with the
Blowfish shortcodes for the tags and link:

```html
<!-- DineSafeViz project card -->
<div class="not-prose mx-auto mt-10 max-w-md rounded-2xl border border-neutral-200 dark:border-neutral-700 bg-neutral-50 dark:bg-neutral-800 p-6 text-left shadow-sm">
  <h3 class="text-xl font-bold text-neutral-800 dark:text-neutral-100">DineSafeViz</h3>
  <p class="mt-2 text-neutral-600 dark:text-neutral-300">
    A containerized web app that visualizes 26 years of Toronto Public Health DineSafe
    food-inspection data.
  </p>
  <div class="mt-4 flex flex-wrap gap-2">
    {{< badge >}}Terraform{{< /badge >}}
    {{< badge >}}Ansible{{< /badge >}}
    {{< badge >}}Docker{{< /badge >}}
    {{< badge >}}PostgreSQL{{< /badge >}}
  </div>
  <div class="mt-5">
    <!-- TODO: swap href to https://dinesafeviz.com once it resolves -->
    {{< button href="https://github.com/im-kenough/DineSafeViz" target="_blank" rel="noopener noreferrer" >}}View DineSafeViz on GitHub{{< /button >}}
  </div>
</div>
```

This is a **starting point**, not a pixel spec — the implementer should adjust classes to
hit the quality bar (spacing, contrast, responsive behaviour) and may instead use pure
Blowfish shortcodes if that reads more cleanly. What matters is the *result* against the
quality bar, not these exact class names. Remove or repurpose the existing experience-
highlights `TODO` comment as appropriate (leave it if the owner still wants that block; it
is orthogonal to the card).

### P0.3 — Verify the build and the render
- `hugo` builds with no errors or broken partials.
- The card renders below the profile, with the badges and button showing (confirm the
  shortcodes resolved — no literal `{{< badge >}}` text on the page).
- Legible in **dark and light**; **narrow viewport** doesn't overflow or crowd.
- The link opens the correct target in a new tab; `rel="noopener noreferrer"` is present.
- The GitHub Actions deploy workflow still succeeds.

---

## P1 — Should do (cheap polish)

- **P1.1** Add the optional second line (Terraform/Packer/Ansible + AKS) **only if** the
  card looks sparse. Don't pad it.
- **P1.2** Add a subtle hover/focus affordance on the card or its button so it reads as
  interactive (respect the theme's existing hover styles).
- **P1.3** If `content/_index.md` still carries the experience-highlights `TODO`, decide
  with the owner whether the card sits above or below that block once both exist. For now,
  card first (it's the higher-ROI element).
- **P1.4** Sanity-check the `README.md` intro line still matches reality after this change
  (the MVP spec's P1.3 already flagged the "basic landing page" wording).

## Out of scope (leave for later)

- The **two-link** version of the card (repo *and* live app) — that comes once AKS is live
  behind `dinesafeviz.com` (see `funnel-map.md` long-term).
- A full Projects *page* / multiple cards — one card only for now.
- Building the `dinesafeviz.com` holding page, registering the domain, or the Cloudflare
  redirect — tracked separately in `jh-2026/to-do/todo.md`.
- Experience-highlights HTML block (separate MVP-spec item).

---

## Deliverable: create GitHub issues, don't just edit files

After (or instead of) making changes, **create GitHub issues** in the
`im-kenough/im-kenough.github.io` repo using the `gh` CLI. Produce **two kinds**:

### 1. Implementation issues (`[impl]`)
One issue per discrete change; include the change, the file(s), the acceptance criterion, a
sub-step checklist where useful, and the priority label. Example:

```bash
gh issue create \
  --title "[impl] P0.2 Add DineSafeViz project card to homepage body" \
  --label "P0,homepage" \
  --body "Author a DineSafeViz card in content/_index.md using the canonical one-liner, 3-4 tech-tag badges, and a button linking to the repo (TODO: swap to dinesafeviz.com once live). Requires the homepage layout to render .Content (P0.1). Acceptance: card renders below the profile, badges + button resolve, legible in dark/light, no overflow on mobile. See docs/homepage-dinesafeviz-card-spec.md#p02."
```

### 2. Validation issues (`[validate]`) — human sign-off
Verification tasks only a human should confirm. Examples to create:
- `[validate] Confirm the DineSafeViz one-liner on the card matches the resume/LinkedIn wording verbatim`
- `[validate] Decide the card's tech tags (which 3-4, and their order)`
- `[validate] Confirm the card link target (repo now, or wait for dinesafeviz.com)`
- `[validate] View the deployed card on mobile + desktop, dark + light; spacing and contrast OK`
- `[validate] Confirm the homepage layout switch (background -> profile) is intended`

Link each validation issue back to its implementation issue where they pair up.

If `gh` is unavailable or unauthenticated, output the full issue list (titles + bodies +
labels) as paste-ready markdown and say so explicitly.

## Definition of done

- [ ] Homepage renders a page body (layout switched off `background`, or already was) (P0.1).
- [ ] A single DineSafeViz card shows the canonical one-liner, 3–4 tech tags, and one link
      out (P0.2).
- [ ] Card link points at the repo now, with a `TODO` to swap to `dinesafeviz.com`; opens
      in a new tab with `rel="noopener noreferrer"`.
- [ ] `hugo` builds clean; shortcodes resolve (no literal `{{< … >}}` on the page); deploy
      workflow green (P0.3).
- [ ] Card is legible in dark and light and does not overflow/crowd on a narrow viewport.
- [ ] No phone number, no personal email, no resume PDF added.
- [ ] Implementation and validation issues created (or output as paste-ready markdown).
- [ ] Unknowns (final tags, link target, layout choice) left as `<!-- TODO -->` and/or
      captured as `[validate]` issues, never guessed.
