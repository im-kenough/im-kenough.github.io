# Local preview

The site is static — no build. Serve the `src/` folder directly:

    python3 -m http.server -d src 8000

Then open <http://localhost:8000>.

## Verifying zero external dependencies

With the page open, check the browser DevTools Network tab (or the
chrome-devtools MCP `list_network_requests`). Every request must go to
`localhost` except the optional Umami analytics tag (`cloud.umami.is`).
Blocking Umami must not change how the page renders.

## Verifying the SECRET banner

The banner is gated on the `<html data-env="...">` attribute:
- `data-env="production"` (default in the committed file): no banner.
- `data-env="staging"`: SECRET banners at top and bottom.

To preview the staging state locally, temporarily edit the attribute to
`staging` (CI does this substitution automatically on the staging branch —
do not commit the change).
