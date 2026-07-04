
# kennethho.ca - My personal website 🌐

Welcome to the repository for [`kennethho.ca`](https://kennethho.ca), my personal website. The site serves as a professional portfolio landing page, linking to my [Github](https://github.com/im-kenough), [LinkedIn](https://www.linkedin.com/in/kenneth-yyz) page, and [DineSafeViz](https://github.com/im-kenough/DineSafeViz) project.

## Project Overview 🚀
This is a statically generated Hugo website using the Blowfish theme hosted on GitHub Pages and deployed automatically via GitHub Actions.

It also uses a custom domain from Namecheap, with Cloudflare providing DDoS mitigation and proxying. Web analytics is monitored using Google Analytics, Cloudflare Web Analytics, and Umami.

### Tech Stack ⚙️:

- **Static Site Generator:** [Hugo](https://gohugo.io/)
- **Theme:** [Blowfish](https://themes.gohugo.io/themes/blowfish/)
- **Hosting:** [GitHub Pages](https://pages.github.com/)
- **DNS:** Custom [Namecheap](https://www.namecheap.com/) domain with DNS records & [DNSSEC](https://dnssec-analyzer.verisignlabs.com/kennethho.ca) pointed to [Cloudflare](https://www.cloudflare.com/en-ca/learning/cdn/glossary/reverse-proxy/)
- **Web Analytics:** [Cloudflare](https://www.cloudflare.com/en-ca/web-analytics/) Web Analytics, [Umami](https://umami.is/) Web Analytics
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
  - **GitHub Actions:** Automated [build and deployment](.github/workflows/deploy.yml) pipeline via GitHub Actions.
- **SEO Optimized:** Proper metadata and [robots.txt](layouts/robots.txt) configuration for SEO. 🔍
  - **Branding:** [kennethho.ca](https://kennethho.ca) custom domain from Namecheap.

- **Analytics:** Integrated with Google Analytics, Cloudflare Web Analytics, and Umami for web traffic insights 📊.

## Roadmap 🛤️

Coming soon 🚧

### Features 🌟
- **Monitoring:** 📈
  - **Uptime monitoring:** Uptime monitoring with [Uptime Kuma](https://github.com/louislam/uptime-kuma) 
  - **JavaScript Error Logging:** Detect JS errors on users' browsers with [LogRocket](https://logrocket.com/)
- **Alerting:** 🔔 Receive service notifications on [Discord](https://github.com/caronc/apprise/wiki/Notify_discord) server