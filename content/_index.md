---
title: "Home"
---

<div class="not-prose mx-auto mt-12 max-w-md w-full">
  <hr class="mb-8 border-neutral-800 dark:border-neutral-100" />
  <h2 class="text-2xl font-bold text-left text-neutral-800 dark:text-neutral-100 mb-6">Personal Projects</h2>

  <!-- DineSafeViz project card -->
  <div class="rounded-2xl border border-neutral-200 dark:border-neutral-700 bg-neutral-50 dark:bg-neutral-800 p-6 text-left shadow-sm hover:shadow-md transition-shadow duration-200">
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
</div>

<!-- TODO: Surface the resume's content as a short experience highlights block in page HTML. Draft for the owner to refine before publishing:

Cloud Systems Administrator and DevOps Analyst with 11+ years keeping mission-critical systems running across aerospace, banking, and healthcare.
- Build and maintain CI/CD pipelines for Azure Kubernetes Service; lifted build cadence 57% on a 400-engineer platform.
- Automate the toil: patched 350+ VMs on schedule (cleared 80% of outstanding vulnerability alerts) and replaced manual onboarding with a Python tool spanning M365 and SaaS APIs.
- Infrastructure as Code with Terraform and Ansible, on-prem (Proxmox) and on Azure.
-->
