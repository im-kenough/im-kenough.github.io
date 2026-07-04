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
