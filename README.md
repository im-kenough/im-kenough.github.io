# kennethho.ca

Welcome to [`kennethho.ca`](https://kennethho.ca), the repository for my personal website.

It's a portfolio landing page linking to my [GitHub](https://github.com/im-kenough), [LinkedIn](https://www.linkedin.com/in/kenneth-yyz), and [DineSafeViz](https://github.com/im-kenough/DineSafeViz) project.

This is a static single-page site with no build step. The page uses pinned [Astro UXDS](https://astrouxds.com/) Web Components.

## Tech stack

- **UI components:** [Astro UXDS](https://astrouxds.com/) Web Components, vendored at `@astrouxds/astro-web-components@8.0.0` under `src/vendor/astro/`.
- **Hosting:** [GitHub Pages](https://pages.github.com/) (production, `main`), [Cloudflare Pages](https://pages.cloudflare.com/) (staging, `staging`).
- **DNS:** Custom [Namecheap](https://www.namecheap.com/) domain, with DNS and [DNSSEC](https://dnssec-analyzer.verisignlabs.com/kennethho.ca) pointed at [Cloudflare](https://www.cloudflare.com/en-ca/learning/cdn/glossary/reverse-proxy/).
- **Analytics:** [Cloudflare Web Analytics](https://www.cloudflare.com/en-ca/web-analytics/) and [Umami](https://umami.is/).
- **CI/CD:** [GitHub Actions](https://docs.github.com/en/actions).

## Features

- **Responsive:** Works across devices and screen sizes.
- **Performant:** High [PageSpeed](https://pagespeed.web.dev/) scores for fast loads and low data usage, with static objects cached on Cloudflare's [CDN](https://www.cloudflare.com/en-ca/application-services/products/cdn/).
- **Security:**
  - **DNS proxy:** Origin hidden behind Cloudflare's reverse proxy.
  - **DDoS mitigation:** Cloudflare's DDoS protection.
  - **WAF:** Cloudflare issues HTTPS challenges and blocks suspicious connections.
  - **DNSSEC:** DNS responses signed to prevent spoofing.
- **Automated deploys:** Pushes ship through a GitHub Actions [pipeline](.github/workflows/deploy.yml).
- **Staging environment:** The `staging` branch deploys to [stg.kennethho.ca](https://stg.kennethho.ca) for previewing changes before production. Staging carries a SECRET classification banner so it's never mistaken for the live site.
- **SEO:** Metadata and [robots.txt](src/robots.txt) tuned for search, on the [kennethho.ca](https://kennethho.ca) custom domain.

## Design decisions

Goal: Create a personal site that minimizes dependencies with reasonable security.

- **Minimal dependencies**
  - Fonts and CSS hosted locally, so the site renders without external CDNs.
  - Only the required [Astro UXDS](https://astrouxds.com/) components are vendored.
  - Migrated off the Hugo static site generator, dropping the build step and unused dependencies.
  - Keep the staging banner in the HTML and reveal it client-side from the `stg.*` hostname, so no build-time stamping is needed.
- **Operational excellence**
  - Deploy a Staging environment to test site changes and Dependabot updates before production deployment, minimizing disruption.
