+++
title = "Maestro"
summary = "A tool for sharing music across a variety of different streaming services."
date = "2022-03-13"
cover = "/images/maestro/cover.png"
keywords = ["music", "sharing", "helm"]
author = "Eoin Motherway"
+++

## What is Maestro?

Maestro is a small web application that lets users share music across a variety of different streaming services.

## How does it work?

Maestro accepts links to artists, albums, and tracks from a number of different music streaming services.

If Maestro has seen the given link before, it'll return a cached set of results from it's database.
If Maestro hasn't seen the link before, it determines which streaming service the link came from (based on the domain name), then uses that streaming services REST API to get some metadata for the artist, album or track.

Once Maestro has the metadata from the originating streaming service, it then queries the remaining streaming service APIs.
It then groups the results together, stores them in a database, and then presents the results to the user.

Overall, not too complicated, and it works like magic!

{{< image src="/images/maestro/example.gif" alt="An example of Maestro in use" >}}

## How does it run?

The frontend is powered by [Remix.run](https://remix.run) and [Tailwind CSS](https://tailwindcss.com), the backend is a simple REST API written in Go, and the database is a managed [MongoDB](https://www.mongodb.com) database provided by [DigitalOcean](https://www.digitalocean.com/products/managed-databases) ([Heres a referral if you want some credit](https://m.do.co/c/9cc994ee28e7)).

The frontend and backend are bundled as a [Helm chart](https://github.com/YuKitsune/Maestro/blob/main/deployments/helm/maestro/README.md), and deployed to a managed Kubernetes cluster, also provided by DigitalOcean.

{{< image src="/images/maestro/diagram.png" alt="Architecture diagram" >}}

## Why?

There are lots of different music streaming services out there, and it can be easy to forget that not everyone uses Spotify. Normally, when two people use different music streaming services and they want to share music with each other, the recipient would usually have to search for the same artist, album or track on their own service, which can be inconvenient.

Maestro solves this by doing the hard work for you, aggregating all the links in one place, and providing a new, sharable link to the content.

{{< image src="/images/maestro/embed.png" alt="Maestro link embedded into a Discord chat" >}}

Maestro also served as a learning project for myself, as it helped me learn more about the Go programming language, the Remix framework, and MongoDB.

## What's next?

I'm currently looking into supporting playlists and expanding the current list of supported streaming services. If you'd like to help out, feel free to submit a pull request!

## Source

The Maestro source code is available on GitHub over at [https://github.com/yukitsune/maestro](https://github.com/yukitsune/maestro). Feel free to check it out, give it a star, and contribute to the project if you've got some ideas!
