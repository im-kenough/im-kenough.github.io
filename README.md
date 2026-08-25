# kennethho.ca

Welcome to the repository for [`kennethho.ca`](https://kennethho.ca), my personal website. 

The site serves as a professional portfolio landing page, linking to my [Github](https://github.com/im-kenough), [LinkedIn](https://www.linkedin.com/in/kenneth-yyz), and [DineSafeViz](https://github.com/im-kenough/DineSafeViz) project.

This is a static single-page site  with no build step. The page
is built directly from vendored [Astro UXDS](https://astrouxds.com/) Web
Components and deployed automatically via GitHub Actions: `main` publishes to
GitHub Pages, and `staging` publishes to Cloudflare Pages.

## Tech Stack

- **UI components:** [Astro UXDS](https://astrouxds.com/) Web Components, vendored at `@astrouxds/astro-web-components@8.0.0` under `src/vendor/astro/`
- **Hosting:** [GitHub Pages](https://pages.github.com/) (production, `main`), [Cloudflare Pages](https://pages.cloudflare.com/) (staging, `staging`)
- **DNS:** Custom [Namecheap](https://www.namecheap.com/) domain with DNS records & [DNSSEC](https://dnssec-analyzer.verisignlabs.com/kennethho.ca) pointed to [Cloudflare](https://www.cloudflare.com/en-ca/learning/cdn/glossary/reverse-proxy/)
- **Web Analytics:** [Cloudflare](https://www.cloudflare.com/en-ca/web-analytics/) Web Analytics, [Umami](https://umami.is/) Web Analytics (Umami is the only analytics tag present in the page source; Cloudflare Web Analytics is injected at the Cloudflare proxy layer, not in-source)
- **CI/CD:** [GitHub Actions](https://docs.github.com/en/actions)

## Features

- **Responsive Design:** Works on all devices and screen sizes.
- **Performant:**
  - **Benchmarking:** High scores on [PageSpeed](https://pagespeed.web.dev/) tests mean less data usage for users and faster load times.
  - **Caching:** Faster load times by caching static objects on Cloudflare's [CDN](https://www.cloudflare.com/en-ca/application-services/products/cdn/)
- **Security:**
  - **DDoS Mitigation, DNS proxy:** Secured using Cloudflare’s DDoS protection and proxying services.
  - **WAF:** Uses Cloudflare to issue HTTPs challenge/blocking of suspicious connections
- **Automation:**
  - **GitHub Actions:** Automated [deployment](.github/workflows/deploy.yml) pipeline via GitHub Actions.
- **Staging environment:** The `staging` branch deploys to Cloudflare Pages at [stg.kennethho.ca](https://stg.kennethho.ca) for previewing changes before they reach production; staging deploys display a SECRET classification banner so they are never mistaken for the live site.
- **SEO Optimized:** Proper metadata and [robots.txt](src/robots.txt) configuration for SEO.
  - **Branding:** [kennethho.ca](https://kennethho.ca) custom domain from Namecheap.
- **Analytics:** Integrated with Cloudflare Web Analytics and Umami for web traffic insights.

## Design Decisions

Key requirements: Deploy a personal website that minimizes dependencies and provides reasonable security, leading to these design decisions:

- Minimize dependencies
  - Host fonts and css files locally to avoid relying on external CDNs and more providers. Ensures site can at least render
  - Migrated from a Hugo static site generator and template
    - Eliminated a build step and additional dependencies since most features wern't used
  - Locally host only required components of [Astro UXDS](https://astrouxds.com/) Web
Components

- Operational Excellence
  - Staging: Deploy website changes and dependabot updates to a staging environment before production environment to minimze disruptions