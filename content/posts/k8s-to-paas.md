+++
title = "Moving from Kubernetes to PaaS"
summary = "A Journey to Simplify Deployment, save time, and money."
date = "2023-02-28"
author = "Eoin Motherway"
+++

Kubernetes has been a popular choice for running applications due to its flexibility and scalability.
It is also a valuable skill to have, making it a go-to tool for many developers.
However, as projects grow, managing a Kubernetes cluster can become complex, especially for small projects.
This can lead to prohibitive pricing and cause headaches for those maintaining the cluster.
In this post, I'll share my experience of moving from running everything on a Kubernetes cluster to running everything on a PaaS (Platform as a Service), including the pros and cons of each approach.

## The Initial Desire to Use Kubernetes

When I first started deploying applications, I was drawn to Kubernetes because of its flexibility and scalability.
I liked the idea of having a single tool to run everything, from small projects to large, complex applications.

Additionally, learning Kubernetes was a valuable skill to have, and I wanted to add it to my skillset.

## Using Kubernetes for All the Things

I started my Kubernetes journey with [DigitalOcean's Kubernetes](https://www.digitalocean.com/products/kubernetes) offering to host my blog and a few Discord bots. As my cluster grew, I added more services like [ChartMuseum](https://chartmuseum.com) and [Maestro](/showcase/maestro), and the [Prometheus stack](https://github.com/prometheus-operator/kube-prometheus).

Using Kubernetes had its advantages and disadvantages. On the positive side, I appreciated how the deployments could be described in YAML, which made them easy to manage and version control in a Git repository. I also found it convenient that I could automate deployments using GitHub Actions.

However, Kubernetes had its share of challenges. When things went wrong, diagnosing issues was often difficult, and troubleshooting required a significant amount of time and effort. Resource exhaustion also eventually became a problem, and adding more nodes to the cluster became prohibitively expensive. 

In the end, I found that Kubernetes was complete overkill and far too expensive for my needs, which led me to explore other options.

## Exploring Platforms as a Service

In contrast to Kubernetes, which is a container orchestration system, Platforms as a Service (PaaS) are cloud computing services that provide developers with a platform to develop, run, and manage applications without the need for building and maintaining the underlying infrastructure.
In essence, PaaS solutions offer a pre-built, ready-to-use environment that developers can use to deploy their applications, eliminating the need for manual configuration.

There are many different PaaS offerings available on the market, each with their own unique features and pricing models.
Some of the most popular PaaS offerings include [Vercel](https://vercel.com), [Azure App Service](https://azure.microsoft.com/en-au/products/app-service/), [Google Cloud Run](https://cloud.google.com/run/), and [Heroku](https://www.heroku.com).
These platforms provide various levels of support for different programming languages, frameworks, and application types.

Using a PaaS has its advantages and disadvantages.
On the one hand, PaaS offerings often have easy-to-use interfaces, which allow developers to quickly deploy their applications with minimal configuration. 
Additionally, PaaS solutions generally take care of many of the underlying infrastructure tasks, such as scaling and load balancing, which can save developers a significant amount of time and effort.

On the other hand, PaaS solutions can have some downsides.
For example, PaaS solutions may have limitations on the types of applications that can be deployed or the level of control that developers have over the underlying infrastructure.

## Moving to Platform as a Service

Moving to a PaaS from Kubernetes required finding an affordable and suitable option.

Vercel was an obvious choice for hosting the blog since it supports Hugo and has reasonable pricing.
The process of deploying the blog was effortless, and it was up and running within minutes.

Maestro, on the other hand, required a full-stack deployment, which Vercel didn't support.
I initially explored Azure App Platform, but its complexity made it unsuitable for such a small hobby projects.
I ended up choosing DigitalOcean App Platform due to its fair pricing and my prior experience with DigitalOcean.
Although [some changes]({{< ref "/showcase/maestro#migrating-away-from-kubernetes" >}}) were required to the container before deploying Maestro, the app was up and running within seconds once connected to the repository.

<!-- Todo: Expand on the process, maybe provide a walkthrough? -->

## Conclusion

Moving from running everything on a Kubernetes cluster to running everything on a PaaS was a decision that brought many benefits.

While Kubernetes had its advantages, the complexities of managing a Kubernetes cluster on my own, especially for small projects, proved to be a major obstacle.

The experience of moving to Vercel for my blog and DigitalOcean App Platform for Maestro was a breath of fresh air. The simplicity and speed of deployment were impressive, and it was cost-effective too. I was pleasantly surprised by how easy it was to get up and running.
I will definitely seek to use PaaS offerings for future projects where suitable.

That said, Kubernetes still has a place in my life, as I still use [K3s](https://k3s.io) throughout my home lab running various self-hosted services, and helping me maintain my kubernetes skills.
