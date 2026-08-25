## Updating the vendored UI library

Components are pinned at `@astrouxds/astro-web-components@8.0.0`, vendored under
`src/vendor/astro/` (only the chunks the page uses). To update: bump the version,
download the pinned package, load the page against a full copy to capture the
chunks it requests, copy those plus the CSS and Roboto fonts into
`src/vendor/astro/`, and commit the refreshed folder.
