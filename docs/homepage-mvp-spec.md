# Homepage MVP Revision Spec

Instructions for an LLM coding agent to bring [`kennethho.ca`](https://kennethho.ca) up to
a minimum credibility bar for a job search. This is a [Hugo](https://gohugo.io/) site using
the [Blowfish](https://blowfish.page/) theme, deployed to GitHub Pages via GitHub Actions.

> The homepage is the destination that the resume, cover letter, and LinkedIn all funnel
> into. **A link is a promise.** Right now the page is a background image with two header
> links. It should look intentional and point a reader at the things that vouch for the
> candidate. The goal is *minimum bar*, not a rebuild — do not over-build.

## Goal

A reader who lands on the homepage should, within ~10 seconds:
1. Know who this is and what they do (one positioning line).
2. Have a clear path to LinkedIn, GitHub, and the DineSafeViz project.
3. See nothing broken, placeholder, or half-finished.

## Current state (verified)

- `config/_default/params.toml`: homepage `layout = "background"`, image `img/lcars0.webp`.
  This layout renders **only** a background image plus the header menu. There is no
  `content/` directory and no homepage text.
- `config/_default/menus.en.toml`: header menu has **LinkedIn** and **GitHub** only.
- No positioning line, no DineSafeViz link, no avatar/name block.
- `README.md` Roadmap lists uptime monitoring, JS error logging, and alerting as
  "Coming soon" — out of scope for this MVP; leave as roadmap.

## Quality bar (apply to every change)

- **Readable / skimmable.** One screen, no scrolling required to get the point.
- **Funnel-consistent.** The positioning line should reuse the LinkedIn headline wording
  so the candidate reads the same across every channel.
- **No PII.** See constraints below — this is a hard requirement, not a preference.
- **No broken or placeholder content.** Every link resolves; no "Coming soon" on the
  landing page itself; no Lorem ipsum.
- **Looks deliberate.** Consistent theme, working images, sensible spacing.

## Privacy constraints (hard requirements)

The owner has decided to keep personally identifying information off the public site.
LinkedIn at least sits behind a login wall; a static page does not.

- Do **not** add a phone number anywhere.
- Do **not** publish a primary personal email. If a contact path is wanted, use a
  dedicated job-search alias or a contact form, and confirm the address with the owner
  before committing it — do **not** invent one.
- Do **not** host a resume PDF on this site — not even a phone/email-stripped variant.
  It's redundant with LinkedIn (the better-maintained copy), drifts out of sync, and is
  weaker than the tailored PDF sent directly to employers. Link to LinkedIn instead, or
  use "full resume available on request." The resume's content is surfaced as on-page
  HTML highlights instead (see P1.4), which a PDF download cannot match for discovery.
- If any analytics keys, tokens, or verification IDs are added, confirm they are meant
  to be public (most are) and never commit secrets.

---

## P0 — Must do (the minimum bar)

### P0.1 — Add a positioning line and name to the landing page
The `background` layout shows no text. Two options; **recommend Option A**:

- **Option A (recommended): switch the homepage to the Blowfish `profile` layout.** It
  renders an avatar (`img/kenough.jpeg` already exists in `assets/img/`), a name, a short
  tagline, and a row of social/link buttons — exactly this use case. Set in
  `config/_default/params.toml` `[homepage] layout = "profile"`, then configure the
  profile (name, tagline, image, buttons) per the
  [Blowfish homepage docs](https://blowfish.page/docs/homepage-layout/). The tagline
  should reuse the LinkedIn headline:
  `<!-- TODO: confirm exact tagline wording with owner; draft: "Cloud Systems Administrator | DevOps Analyst — 11+ yrs keeping mission-critical systems running" -->`
- **Option B (keep the LCARS aesthetic): stay on `background`** and overlay a short
  positioning line + link buttons via a homepage content file / custom partial. More work,
  more custom code. Only do this if the owner specifically wants to keep the current look.

Pick one, implement it, and leave the other documented in the validation issue so the
owner can choose.

### P0.2 — Add a DineSafeViz link
The resume and LinkedIn point readers here expecting to reach the portfolio project, but
there's no link to it. Add **DineSafeViz** alongside LinkedIn and GitHub.

- Short term, point it at the repo: https://github.com/im-kenough/DineSafeViz
- Add as a header menu item in `menus.en.toml` (and/or a profile button if using
  `profile` layout). Use a sensible weight so order reads: GitHub, LinkedIn, DineSafeViz
  (or group the project separately from the social links).
- `<!-- TODO: swap to the live/showcase URL (e.g. dinesafeviz.com) once it exists -->`

### P0.3 — Verify the build and the deploy
- `hugo` builds with no errors and no broken theme partials (recent commits fixed header
  partial paths — confirm they're still good).
- All images referenced actually exist in `assets/img/`.
- The GitHub Actions deploy workflow still succeeds.

---

## P1 — Should do (cheap polish)

- **P1.1** Ensure the page title and meta description (`config/_default/languages.en.toml`
  / `hugo.toml`) read like a professional landing page, not theme defaults.
- **P1.2** Confirm dark/light appearance both render the positioning text legibly over
  whatever background/image is used (contrast check).
- **P1.3** Update `README.md`: the intro still says "a basic landing page linking to my
  GitHub and LinkedIn." Once DineSafeViz is linked and a tagline exists, reflect that.
- **P1.4 (owner deciding — leave as `<!-- TODO -->` until confirmed)** Surface the resume's
  *content*, not a PDF, as a short **experience highlights** block in page HTML: 3–5 lines,
  skimmable, Google-indexable (so the owner's own site ranks when their name is searched —
  a PDF behind a download button does not). This replaces hosting a resume file. Draft for
  the owner to refine before publishing:
  > Cloud Systems Administrator and DevOps Analyst with 11+ years keeping mission-critical
  > systems running across aerospace, banking, and healthcare.
  > - Build and maintain CI/CD pipelines for Azure Kubernetes Service; lifted build cadence
  >   57% on a 400-engineer platform.
  > - Automate the toil: patched 350+ VMs on schedule (cleared 80% of outstanding
  >   vulnerability alerts) and replaced manual onboarding with a Python tool spanning M365
  >   and SaaS APIs.
  > - Infrastructure as Code with Terraform and Ansible, on-prem (Proxmox) and on Azure.

## Out of scope (leave as roadmap)

- Uptime monitoring, JS error logging, Discord alerting (README roadmap).
- A blog/posts section, a full Projects page with write-ups (that's medium-term).
- Hosting the resume PDF (privacy decision: don't).

---

## Deliverable: create GitHub issues, don't just edit files

After (or instead of) making changes, **create GitHub issues** in the
`im-kenough/im-kenough.github.io` repo using the `gh` CLI. Produce **two kinds**:

### 1. Implementation issues (work for the agent / owner to do)
One issue per discrete change. Title prefix `[impl]`. Each issue body must include:
- the change, the file(s) involved, and the acceptance criterion
- a checklist of sub-steps where useful
- the priority label (`P0`/`P1`)

Example:
```bash
gh issue create \
  --title "[impl] P0.1 Add positioning line + name to homepage (profile layout)" \
  --label "P0,homepage" \
  --body "Switch [homepage] layout to 'profile' in params.toml; set name, tagline (reuse LinkedIn headline), avatar img/kenough.jpeg, and link buttons. Acceptance: landing page shows name + one positioning line + links without scrolling. See docs/homepage-mvp-spec.md#p01."
```

### 2. Validation issues (checks for the human owner to sign off)
These are *verification* tasks for the owner — things only a human should confirm. Title
prefix `[validate]`. Examples to create:
- `[validate] Confirm final tagline wording matches the LinkedIn headline`
- `[validate] Confirm no phone number or personal email appears anywhere on the live site`
- `[validate] Decide Option A (profile layout) vs Option B (keep LCARS background)`
- `[validate] Confirm DineSafeViz link target (repo now, or wait for live URL)`
- `[validate] View the deployed site on mobile + desktop; text legible over background`

Link each validation issue back to its implementation issue where they pair up.

If `gh` is unavailable or unauthenticated, output the full list of issues (titles +
bodies + labels) as markdown so the owner can paste them in, and say so explicitly.

## Definition of done

- [ ] Landing page shows a name and one positioning line (P0.1).
- [ ] DineSafeViz is linked alongside LinkedIn and GitHub (P0.2).
- [ ] `hugo` builds clean; deploy workflow green; all referenced images exist (P0.3).
- [ ] No phone number, no personal email, no resume PDF on the site.
- [ ] No "Coming soon" / placeholder text on the landing page itself.
- [ ] Implementation issues and validation issues created (or output as paste-ready
      markdown if `gh` is unavailable).
- [ ] Unknowns (tagline wording, contact alias, layout choice) are left as
      `<!-- TODO -->` and/or captured as `[validate]` issues, never guessed.
