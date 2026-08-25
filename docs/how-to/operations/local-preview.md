# Local preview

The site is static — no build. Serve the `src/` folder directly:

```bash
python3 -m http.server -d src 8000
```

Then open the URL.
```bash
http://localhost:8000
```


## Verifying zero external dependencies

With the page open, check the browser DevTools Network tab (or the
chrome-devtools MCP `list_network_requests`). Every request must go to
`localhost` except the optional Umami analytics tag (`cloud.umami.is`).
Blocking Umami must not change how the page renders.

## Previewing production vs. staging

Production and staging serve the exact same files. The only difference is the
`data-env` attribute on the `<html>` tag in `src/index.html`, which the CSS uses
to gate the SECRET banner:

- `data-env="production"` (the committed default): no banner. This is what
  `kennethho.ca` shows.
- `data-env="staging"`: SECRET banners pinned at the top and bottom. This is
  what `stg.kennethho.ca` shows.

You don't need two servers to see both states. Keep the server from the previous
section running and flip the attribute in place.

### View the production state

The committed file is already in the production state, so just open the local
URL. You'll see the page with no banner.

### View the staging state

1. Flip the attribute to `staging`. Run this from the repository root in a second
   terminal:

   ```bash
   sed -i 's/data-env="production"/data-env="staging"/' src/index.html
   ```

   This is the same substitution the staging deploy runs in CI, so the local
   result matches `stg.kennethho.ca`.

2. Reload the local URL in your browser. The SECRET banners now appear at the top
   and bottom of the page.

3. Revert the change when you're done so you don't commit the staging state:

   ```bash
   git checkout src/index.html
   ```

<!-- prettier-ignore -->
> [!IMPORTANT]
> Never commit `src/index.html` with `data-env="staging"`. Production reads the
> committed value directly, so a stray `staging` would show the SECRET banner on
> the live site. CI flips the attribute at deploy time, so the file must stay
> `production` in the repository.
