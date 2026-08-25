# UI customization

This page is a reference for changing how the site looks. The page is
hand-authored static HTML and CSS with no build step, so every change here is a
direct edit to a file in `src/` that takes effect the moment it's deployed.
Start with the file map to find the right place, then use the tables to find
the exact value to change.

## Where the UI lives

The visible page is assembled from four files. You edit the first three; you
never edit the fourth by hand.

| File                              | What it controls                                      |
| --------------------------------- | ----------------------------------------------------- |
| `src/index.html`                  | Page content and structure: text, links, which components appear |
| `src/styles/site.css`             | Layout and look: backdrop, spacing, text sizes, colors |
| `src/styles/fonts.css`            | The Roboto font faces the page loads                  |
| `src/vendor/astro/`               | Vendored Astro UXDS components. Do not edit directly  |

<!-- prettier-ignore -->
> [!IMPORTANT]
> Don't edit anything under `src/vendor/astro/`. Those files are a pinned copy
> of the Astro UXDS library and get overwritten whenever the library is
> updated. Style the components from `src/styles/site.css` instead, as the
> existing rules do.

## The building blocks

The page is built from Astro UXDS Web Components. These are custom HTML tags
(they start with `rux-`) that render a styled control. You use them like any
other tag in `src/index.html`.

| Tag                        | What it renders                    | Where it's used        |
| -------------------------- | ---------------------------------- | ---------------------- |
| `rux-button`               | A styled button                    | Social links, project link |
| `rux-card`                 | A bordered card with header and footer | The DineSafeViz project |
| `rux-tag`                  | A small pill label                 | The technology tags    |
| `rux-classification-marking` | The SECRET banner strip          | Top and bottom, staging only |

Each button and card link is wrapped in a plain `<a>` tag with the class
`btn-link`, because `rux-button` has no built-in link behavior. To change where
a button goes, edit the `href` on its surrounding `<a>`, not the button.

## Common changes

Each change below is a single value in `src/styles/site.css` unless noted.

### Backdrop darkness

The LCARS background image sits behind a black veil that keeps text readable.
The veil is the pair of `rgba` values on the `body::before` rule:

```css
background: linear-gradient(rgba(0, 0, 0, 0.55), rgba(0, 0, 0, 0.55)),
            url("../img/lcars0-1377x1080.webp") center / cover no-repeat;
```

The `0.55` is the veil's opacity: `0` shows the image at full brightness and
`1` is solid black. Raise it toward `0.65` for a darker backdrop and higher
text contrast; lower it toward `0.45` to show more of the artwork.

<!-- prettier-ignore -->
> [!NOTE]
> Keep both numbers equal. They're the two ends of a gradient, so matching
> values produce an even tint. Different values produce a top-to-bottom fade.

To use a different background image, replace the file at
`src/img/lcars0-1377x1080.webp`, update the filename in this rule, and update
the matching `<link rel="preload">` in the `<head>` of `src/index.html` so the
new image still loads early.

### Text size and weight

The name and tagline are styled by the `.identity` rules. Sizes are in `rem`,
where `1rem` is 16 pixels, so `1.1rem` is about 18 pixels.

| Element    | Selector       | Property      | Current   | Effect of increasing |
| ---------- | -------------- | ------------- | --------- | -------------------- |
| Name       | `.identity h1` | `font-size`   | `2.25rem` | Larger name          |
| Tagline    | `.identity p`  | `font-size`   | `1.1rem`  | Larger tagline       |
| Tagline    | `.identity p`  | `font-weight` | `500`     | Bolder tagline       |
| Tagline    | `.identity p`  | `opacity`     | `0.95`    | Closer to solid white |
| Card text  | `rux-card p`   | `font-size`   | `1.05rem` | Larger project text  |

The font ships four weights: `300`, `400`, `500`, and `700`. Any `font-weight`
you set must be one of those values, or the browser rounds to the nearest one.

### Avatar

The round profile image is the `.avatar` rule. Its size comes from the `width`
and `height` attributes on the `<img>` tag in `src/index.html` (both `128`), not
from the CSS. To resize it, change both attributes together. The CSS controls
only the circle (`border-radius: 50%`) and the faint ring
(`border: 2px solid rgba(255,255,255,0.25)`).

### Colors

The page is dark-mode only. Text is white (`color: #fff` on `body`) and the
base behind the image is black (`background: #000`). The component colors, such
as the button fill and the SECRET banner red, come from the Astro UXDS library
and don't need to be set here.

### Spacing

Gaps between elements use the `gap` property. Increase a value to spread items
apart, decrease it to tighten them.

| Selector | Property | Current  | Controls                        |
| -------- | -------- | -------- | ------------------------------- |
| `.wrap`  | `gap`    | `1.5rem` | Space between the main sections |
| `.social`| `gap`    | `0.75rem`| Space between the social buttons |
| `.tags`  | `gap`    | `0.5rem` | Space between the technology tags |

## Adding or removing content

These changes are in `src/index.html`.

- **A social button:** Copy one of the existing `<a class="btn-link">` blocks in
  the `.social` section, then change its `href` and label. Keep the `target` and
  `rel` attributes so the link opens safely in a new tab.
- **A technology tag:** Add or remove a `<rux-tag>Label</rux-tag>` line inside
  the `.tags` block.
- **A project card:** Copy the whole `<rux-card>` block. Change the header text,
  the description, the tags, and the footer link's `href` and label.

## Fonts

`src/styles/fonts.css` declares the four Roboto weights the page uses, each
loaded from a local `.woff2` file under `src/vendor/astro/fonts/`. The fonts are
self-hosted so the page has no external font request. To change the typeface,
replace the font files and update the `@font-face` rules to match, then update
the `font-family` on `body` in `src/styles/site.css`.

## The SECRET banner

The red SECRET strip at the top and bottom is hidden in production and shown
only on staging. It's controlled by the `data-env` attribute on the `<html>`
tag, which the staging deploy stamps automatically. You don't toggle it by
hand. For how that works, see the CI/CD reference.

To customize the text shown on the banner, you can add a `label` attribute to the `<rux-classification-marking>` elements in `src/index.html` (e.g., `label="SECRET // STAGING"`).

## Previewing your changes

Before you deploy, preview the page locally to see your edits. For the steps,
see the local preview guide.

## Related

- Local preview: [`../how-to/operations/local-preview.md`](../how-to/operations/local-preview.md)
- CI/CD and the staging banner: [`ci-cd.md`](ci-cd.md)
- Updating the vendored Astro UXDS library: [`../../README.md`](../../README.md)
