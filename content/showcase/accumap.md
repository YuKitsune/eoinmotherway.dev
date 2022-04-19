+++
title = "AccuMap - A popular map for the VATSIM network"
date = "2022-03-13"
cover = "/images/accumap/cover.png"
tags = ["map", "flight simulation", "vatsim"]
keywords = ["accumap", "vatsim", "map"]
draft = false
+++

In June 2017, myself along with a number of other flight simulation enthusiasts from the [VATSIM network](https://vatsim.net) came together to develop a new map which could accurately display all pilots and air traffic controllers connected to the network.

VATSIM is an online air traffic simulation network, connecting people from around the world flying online or acting as virtual Air Traffic Controllers.
Air Traffic Control (ATC) is available in our communities throughout the world, operating as close as possible to the real-life procedures and utilising real-life weather, airport and route data. On VATSIM, users can join people on the other side of the planet to fly and control, with nothing more than a home computer.

Similar to websites such as [Flightradar24](https://flightradar24.com), [FlightAware](https://flightaware.com) and [Plane Finder](https://planefinder.net), many map applications have been developed for the VATSIM network, not only showing where people are flying, but also where people can be found providing air traffic control services.

Maps like this have existed for a long time, [VAT-Spy](https://vatspy.rosscarlson.dev) being the most popular map still in use today, but these maps shared a common problem, which was their lack of support for accurately depicting the airspace owned by air traffic controllers.

Most of these maps would highlight an entire FIR (Flight Information Region) when an air traffic controller within that area connected to the network. This can be quite inaccurate as FIRs are often split into multiple separate sectors. Air traffic controllers who are only controlling a subset of these sectors would instead be shown as controlling a much larger area than they actually were.

For example, here is the London FIR:
{{< image src="/images/accumap/fir.png" alt="London FIR" position="center" >}}

This FIR is further split into smaller, more manageable sectors:
{{< image src="/images/accumap/london_sectors.png" alt="London Airspace Sectors on the VATSIM network" position="center" >}}

Air traffic controllers on the VATSIM network often only control one of these sectors at a time, and thus would often need to explain to pilots how most maps weren't showing their true airspace boundaries.
This often resulted in vague explanations in an attempt to teach the pilot where their airspace begins and ends. For new pilots, this can be very confusing, and getting told that "you're not in my airspace" can sometimes be embarrassing.

These older map programs often shipped with outdated data out of the box, which meant that users would have to manually install new data sets by downloading them from forums, navigating into the program files, and replacing a number of `.dat` files.
These files weren't hosted or maintained by a central authority, meaning one file might have updates for Australian airspace, while another might have updates for European airspace, etc. Without some technical knowledge of the file structure, these files  couldn't be combined very easily, which caused a lot of fragmentation in the community.

With these issues in mind, we set out with two main goals:

1. Accurately display the airspace boundaries for air traffic controllers
2. Store the airspace boundaries in a centralized and publicly accessible source, maintained by the community

## Version 1

![Earliest known screenshot of AccuMap (pre-alpha)](/images/accumap/v1_early.png)

AccuMap began development as a desktop application built on [Electron](https://www.electronjs.org) using pure HTML, CSS, and JavaScript.

At the time, we weren't familiar with popular UI frameworks such as Angular and React, so we used the tools we were familiar with, and basically built our own UI framework without realizing it! (It wasn't great...)

The desktop application would retrieve its airspace data from a central server. This data was simply a bunch of KML files accompanied by text files to describe which air traffic controller had ownership over a particular airspace sector.
It was super basic, and super janky... These text files also turned out to be very limited in what they could describe and unfortunately weren't up to the task of describing the hierarchy of airspace sector ownership in certain regions.

![The final version of the AccuMap desktop application](/images/accumap/desktop.png)

Later versions of the AccuMap desktop application included a buddy list, macOS support, airport charts, North Atlantic Tracks, and various other improvements.

## "Please download it again..."

Not long after the release of the desktop application, it became clear that it was riddled with issues such as memory leaks, disappearing aircraft and air traffic controllers, and a flakey auto-update system that never worked. We often had to tell our users to re-download the installer from our website to receive updates, which was embarrassing to say the least.

This time lapse shows some of the issues which plagued AccuMap. You can notice the aircraft icons sometimes disappear, the airspace sectors sometimes double up or disappear, and the overall experience isn't very smooth.

{{< youtube 83pnatv0eH8 >}}

Rather than fixing these issues, we decided to start from scratch and re-write AccuMap as a web application.

## Version 2

In December 2017, we began thinking about what we wanted from AccuMap v2. One of the first decisions we made was to use a strongly typed language, as we were sick of using pure JavaScript.
We eventually decided on C#, as it was strongly typed, and had some great features, tooling, and frameworks for building web applications.
As for the frontend, we still didn't know about UI frameworks like React, so we _somehow_ decided to use Dart. Our rational at the time was that it had more similarities to C# than TypeScript, and we wanted the languages to be similar so we didn't have to learn two new languages at once. **This was a horrible idea**.

Languages aside, we also wanted to add improve our airspace sector depiction capabilities, and provide new tools allowing air traffic controllers inform pilots of any extended coverage, flight path trails, unique aircraft icons, and numerous other features and improvements.

![AccuMap Web Application](/images/accumap/web.png)

AccuMap v2 eventually released with a similar reception to v1 and addressed most of what it set out to do.
Another time-lapse shows how the experience is much smoother overall, but some issues, such as occasionally disappearing airspace sectors, still plagued the app.

{{< youtube 62Lk9Pyivb8 >}}

### The beginning of the end

After running for some time, a number of issues began to surface with AccuMap v2. The server was riddled with performance issues, and required an expensive (at the time) Windows server to run.

One of the main issues with AccuMap was the lack of support from the community. None of us on the AccuMap team were keen on paying for the Windows server to keep it running, and with the community donations slowing down, we decided to pull the plug and shut AccuMap down until we either migrated to ASP.NET Core, or were earning enough from our jobs to be able to pay for the server.

Since then, the original domain name has been taken by scammers, and the source code has remained untouched since 2018.

## Lessons Learned

Looking back on it, we made some pretty _"interesting"_ decisions when designing and developing AccuMap. If we were to write it today from the ground up, things would be completely different.
Something to bear in mind is that we were all amateur programmers at the time, and we had very little exposure to "real-world" code. We mostly went with whatever worked and stuck with it.

We've come a long way since then, but here are some of the biggest lessons we learned from AccuMap.

### Use the right tool for the job

It should've been a web-based application from the very beginning. This also would align with our goal to centralize the airspace data.

We also should've chosen a popular UI framework such as React, Angular, or Vue, instead of rolling our own.
Also, Dart? Really? If I could go back in time, I'd probably slap myself for making that decision.

Another mistake we made was using ASP.NET MVC. To be fair, .NET Core wasn't as well developed as it is today, so this was our only choice if we wanted to use C#. That being said, there were other options out there, such as Next.JS, Spring, etc.

### Backwards compatibility matters

Admittedly, when we would update our desktop application, we would often make a breaking change somewhere. This resulted in a terrible experience for our users, as the auto-update system never actually worked as intended, meaning they would need to re-download and install the app every time we published an update.

To keep the costs down, we also took down the server which AccuMap v1 relied on while developing v2, so the desktop app was basically bricked.

### Renew your domain names

If you've got a website that a lot of people visit, don't forget to renew the domain name. The original AccuMap domain name has since fallen into the hands of scammers, and with links to the original site floating around on forums and Discord messages, it doesn't paint a pretty picture.

### Bugs should have priority over features

Despite the fact that AccuMap was riddled with issues, we still pushed forward with new features, and kept adding to a never ending pile of ideas.
We should've addressed the bugs and performance issues before deciding to re-write and add new features.

### Over-hype

Before we even released v1, we spent a bit of time showing AccuMap off on social media, generating a bit of excitement from the community. A new map on the horizon with some pretty new features certainly generated the hype we were expecting, but once users started using it, it became clear that many users were disappointed with the amount of bugs and performance issues.

### We didn't really know what we were doing

At the end of the day, AccuMap started as a _"wouldn't this be cool"_ project, which eventually grew into something used by a lot of people in the VATSIM community.
Rather than changing our mindset and focusing on it as a product that people use, we kept treating it as a sandbox for ideas.

We also didn't really know how to plan a project, or delegate work. We sorta just threw stuff at the wall to see what would stick.

## The future of AccuMap

It's been a few years since AccuMap officially shut down. Most of the original team still chat regularly, and we've been thinking about what the potential future of AccuMap could look like.

### Sector file import

Something we've been experimenting with recently is importing the same data files that air traffic controllers use in their software.
This would not only mean more accurate data, but it also saves a lot of time as we would no longer need to manually draw the airspace sectors as KML or GeoJSON files.

This, however, can be a problem as some of these sector files contain data which is not "free to reuse or redistribute".

### 3D Map

While not at the top of our wishlist, it'd be great to have a 3D map showing a globe instead of the overused Web Mercator projection.

Mapbox have been making some progress on this recently in their alpha builds.

## So, will there be a v3?

Honestly, who knows?
We're not "actively" working on anything at the moment, but we're certainly throwing ideas around, thinking about how a potential v3 might look.
