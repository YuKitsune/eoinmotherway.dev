+++
title = "Maestro"
summary = "A tool for sharing music across a variety of different streaming services."
date = "2022-03-13"
cover = "/images/maestro/cover.png"
keywords = ["music", "sharing", "helm"]
author = "Eoin Motherway"
+++

Maestro is a small web application that lets users share music across a variety of different streaming services.
The idea came about after I decided to switch from one music streaming service to another, and lost the ability to share music with my friends and colleagues.

## How it works

Maestro accepts share links from a number of different music streaming services.
Once Maestro has received a link, it determines what streaming service the link belongs to (based on the domain name), then uses that streaming services REST API to query for the artist, album or track metadata.

Once Maestro has the metadata, it then performs a search request against the remaining streaming services search APIs.
Once Maestro has results from all streaming services, it groups them together, stores them in a database so that it can be retrieved later, and then presents the results to the user.

All-in-all, not too complicated!

## How it runs

Currently, Maestro has a [Helm chart](https://github.com/YuKitsune/Maestro/blob/main/deployments/helm/maestro/README.md) available for those who'd like to run their own instance in a Kubernetes cluster. This is how it's run on [maestro.yukitsune.dev](https://maestro.yukitsune.dev).

## Future plans

Eventually, I want Maestro to be able to share playlists between services, allowing users to import and maintain playlists from other streaming services.

## Source

The Maestro source code is available on GitHub over at [https://github.com/yukitsune/maestro](https://github.com/yukitsune/maestro). Feel free to check it out, give it a star, and contribute to the project if you've got some ideas!
