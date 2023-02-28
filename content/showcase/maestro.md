+++
title = "Maestro"
summary = "A lightweight web application for sharing music across a variety of music streaming platforms."
date = "2022-03-13"
cover = "/images/maestro/cover.png"
keywords = ["music", "sharing", "helm", "kubernetes", "k8s", "paas"]
author = "Eoin Motherway"
+++

## What is Maestro?

Maestro is a small web application with a simple yet powerful purpose: it lets users share music with each other, regardless of which streaming platform they use. With so many music streaming services available today, it can be frustrating when friends can't easily share and enjoy their favorite tracks together. That's where Maestro comes in. In this blog post, we'll dive into the details of this project, including the problem it solves, how it works, and what I learned while building it.

## How does it work?

Maestro fetches metadata from a user-provided link to an artist, album, or track from their streaming service of choice. It uses this metadata to query other streaming services for matches, and saves the metadata in the database for future reference. Finally, it presents the user with links to all other streaming services and a shareable link to view all links to that artist, album, or track.

{{< image src="/images/maestro/flowchart.png" alt="A flowchart depicting how Maestro aggregates links." >}}

## Tech stack

Maestro's backend is a RESTful API that's written in Go, a statically typed programming language. Go is known for its fast compilation speed and concurrency features, making it a great choice for building scalable and high-performance web services. The backend communicates with a MongoDB database, which stores all the metadata that Maestro fetches from various streaming services.

On the frontend, Maestro is built with TypeScript using the [Remix](https://remix.run) framework. Remix is a modern web framework that focuses on building server-rendered React applications. It's known for its great developer experience, performance, and accessibility. TypeScript is a typed superset of JavaScript that helps catch errors during development and improves the maintainability of large codebases.

Initially, Maestro was deployed as a [Helm](https://helm.sh) chart to a Kubernetes cluster along with other services. However, the two-container approach (One for the frontend, one for the backend) was later simplified into a single container to run both the frontend and backend concurrently. The Helm chart was also deprecated in favor of a simpler deployment strategy.

{{< image src="/images/maestro/diagram.png" alt="An architecture diagram depicting the Maestro frontend and backend running concurrently in a Docker container." >}}

Currently, Maestro is deployed using [DigitalOcean App Platform](https://www.digitalocean.com/products/app-platform), a Platform-as-a-Service (PaaS) that allows for quick and easy deployment of web applications. The database is provided by [MongoDB Atlas](https://www.mongodb.com/atlas/database), a cloud-hosted database service. This new deployment strategy has greatly reduced the complexity and cost of running Maestro.

## Challenges

### Correlating tracks

Earlier versions of Maestro had issues with correlating data across different streaming services by name. This was problematic as artists, albums, and tracks may have slightly different names on different streaming services, leading to errors in searching and matching. Some examples of issues include tracks with more than one artist, names that use different languages across streaming services, and albums named differently (e.g., "Deluxe Edition" albums).

To address this, Maestro started using [ISRC codes](https://en.wikipedia.org/wiki/International_Standard_Recording_Code), a unique identifier for sound recordings and music videos that most streaming services support. However, ISRC codes are specific to recordings (tracks) and not albums or artists, so when correlating albums and artists, Maestro still relies on the name and uses the streaming services' search API.

Despite this limitation, the majority of Maestro users share individual tracks rather than whole albums or artists, so this issue is not a significant concern.

### Migrating away from Kubernetes

<!-- Todo: Link to post about K8s -->
Deploying Maestro into production posed significant challenges. Initially, Maestro was deployed on a Kubernetes cluster as a Helm chart consisting of a separate frontend and backend container. However, maintaining the helm chart proved to be challenging, and updating it was easy to forget, causing various problems. Eventually, the Kubernetes cluster became more of a burden than a benefit, and I decided to migrate most of the services to a Platform-as-a-Service (PaaS). Nevertheless, moving Maestro to a PaaS presented two significant challenges.

#### Merging containers

Initially, Maestro was running as two separate containers: one for the frontend and one for the backend. I could easily bring this across to a PaaS provider, but I would need to pay for the cost of two instances rather than one.

To solve this, I used the [`concurrently`](https://www.npmjs.com/package/concurrently) command to run the frontend and backend processes in the same container, while ensuring that each process was listening on a separate port.
This allowed Maestro to run in a single container serving both the frontend and backend while still keeping them logically separated.

#### Proxying API requests

Another challenge was that most PaaS providers don't allow multiple ports to be exposed by a single container. This presented a problem because the Maestro API is responsible for serving the logos of the streaming services.

I originally considered creating an endpoint in Remix that would provide the logos from the API, however, this wasn't exactly what Remix was designed for, and would be aa pretty nasty hack.

I eventually settled on running Remix behind a custom [`express`](https://www.npmjs.com/package/express) server, and using the [`http-proxy`](https://www.npmjs.com/package/http-proxy) package to proxy requests to the backend.

This allowed the container to have a single port exposed while still maintaining the separation between the frontend and backend.

In hindsight, running a reverse proxy such as [Nginx](https://nginx.org) in the container would probably have been simpler, and a lot less intrusive.

## Learnings

Through this project, I gained valuable experience working with several new tools and technologies, including the Go programming language, the Remix framework, and the TailwindCSS framework. I also had the opportunity to dive into Kubernetes and Helm, and while I found them to be powerful tools, I realized that they were overkill for a small project like Maestro.

However, perhaps the most significant learning experience came from recognizing the importance of balancing the pursuit of perfection with the need to move on and learn new things. At times, I found myself spending too much time trying to perfect this small side project instead of prioritizing my time and efforts on learning new skills and technologies. I came to understand that sometimes it's better to accept that something is good enough and move on to new challenges.

By embracing this mindset, I was able to recognize the value of learning new things and working on new projects. I learned that being a successful engineer isn't just about mastering specific tools or technologies, but also about being able to adapt and learn new things continuously. Overall, this project helped me realize that balancing the pursuit of perfection with the need to move on and learn new things is a critical part of being a successful engineer.

## Links

- [Maestro](https://maestro.yukitsune.dev)
- [GitHub](https://github.com/yukitsune/maestro)
