
# kennethho.ca - My personal website 🌐

Welcome to the repository for [`kennethho.ca`](https://kennethho.ca), my personal website. The site serves as a professional portfolio landing page, linking to my [Github](https://github.com/im-kenough), [LinkedIn](https://www.linkedin.com/in/kenneth-yyz) page, and [DineSafeViz](https://github.com/im-kenough/DineSafeViz) project.

## Project Overview 🚀
This is a hand-authored, static single-page site with no build step. The page
is built directly from vendored [Astro UXDS](https://astrouxds.com/) Web
Components and deployed automatically via GitHub Actions: `main` publishes to
GitHub Pages, and `staging` publishes to Cloudflare Pages.

It also uses a custom domain from Namecheap, with Cloudflare providing DDoS mitigation and proxying. Web analytics is monitored using Cloudflare Web Analytics and Umami.

### Tech Stack ⚙️:

- **UI components:** [Astro UXDS](https://astrouxds.com/) Web Components, vendored at `@astrouxds/astro-web-components@8.0.0` under `src/vendor/astro/`
- **Build step:** None. `src/` is deployed as-is.
- **Hosting:** [GitHub Pages](https://pages.github.com/) (production, `main`), [Cloudflare Pages](https://pages.cloudflare.com/) (staging, `staging`)
- **DNS:** Custom [Namecheap](https://www.namecheap.com/) domain with DNS records & [DNSSEC](https://dnssec-analyzer.verisignlabs.com/kennethho.ca) pointed to [Cloudflare](https://www.cloudflare.com/en-ca/learning/cdn/glossary/reverse-proxy/)
- **Web Analytics:** [Cloudflare](https://www.cloudflare.com/en-ca/web-analytics/) Web Analytics, [Umami](https://umami.is/) Web Analytics (Umami is the only analytics tag present in the page source; Cloudflare Web Analytics is injected at the Cloudflare proxy layer, not in-source)
- **CI/CD:** [GitHub Actions](https://docs.github.com/en/actions)

## Features ✨

- **Responsive Design:** Works on all devices and screen sizes. 📱💻
- **Performant:** ⚡
  - **Benchmarking:** High scores on [PageSpeed](https://pagespeed.web.dev/) tests mean less data usage for users and faster load times.
  - **Caching:** Faster load times by caching static objects on Cloudflare's [CDN](https://www.cloudflare.com/en-ca/application-services/products/cdn/) 🚀
- **Security:** 🔒
  - **DDoS Mitigation, DNS proxy:** Secured using Cloudflare’s DDoS protection and proxying services.
  - **WAF:** Uses Cloudflare to issue HTTPs challenge/blocking of suspicious connections 🚧
- **Automation:** 🤖
  - **GitHub Actions:** Automated [deployment](.github/workflows/deploy.yml) pipeline via GitHub Actions.
- **SEO Optimized:** Proper metadata and [robots.txt](src/robots.txt) configuration for SEO. 🔍
  - **Branding:** [kennethho.ca](https://kennethho.ca) custom domain from Namecheap.

- **Analytics:** Integrated with Cloudflare Web Analytics and Umami for web traffic insights 📊.

## Updating the vendored UI library

Components are pinned at `@astrouxds/astro-web-components@8.0.0`, vendored under
`src/vendor/astro/` (only the chunks the page uses). To update: bump the version,
re-run the vendoring procedure in
`docs/superpowers/plans/2026-08-24-astro-uxds-redesign.md` (Task 3), and commit
the refreshed `src/vendor/astro/`.