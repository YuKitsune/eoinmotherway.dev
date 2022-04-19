+++
title = "AccuMap - A popular map for the VATSIM network"
date = "2022-03-13"
cover = "/images/accumap/cover.png"
tags = ["map", "flight simulation", "vatsim"]
keywords = ["accumap", "vatsim", "map"]
draft = false
+++

## What was AccuMap?

AccuMap was a relatively popular live map of the [VATSIM network](https://vatsim.net), renowned for it's accurate depiction of air traffic control (ATC) sectors and modern user interface.
Myself, along with a number of other VATSIM members threw it together in mid 2017 as a _"wouldn't this be cool"_ project, which eventually gained the attention of the broader VATSIM community.
This lead us to release the map as a desktop application which later evolved into a web based application.

If you're interested to learn about AccuMap's story from it's conception to it's demise, then read on!

## What is VATSIM?

VATSIM is an online air traffic simulation network, connecting people from around the world flying online or acting as virtual air traffic controllers.
Air traffic control is available in VATSIM's communities throughout the world, operating as close as possible to the real-life procedures and utilizing real-world weather, airport and route data.
On VATSIM, users can join people on the other side of the planet to fly and control, with nothing more than a home computer.

### VATSIM Maps

Similar to websites such as [Flightradar24](https://flightradar24.com), [FlightAware](https://flightaware.com) and [Plane Finder](https://planefinder.net), many map applications have been developed for the VATSIM network, not only showing where people are flying, but also where people can be found providing air traffic control services.

VATSIM's most popular map, [VAT-Spy](https://vatspy.rosscarlson.dev) is recognized by the community as the de-facto map of VATSIM, as it's lightweight, easy to use, and generally does a good job at showing ATC. Aerodrome controllers such as delivery, ground, and tower are shown as `D`, `G` and `T` symbols respectively next to the airport markers, approach/departure controllers are shown as ~40nm (nautical mile) circles around an airport, and center/en-route controllers are shown by highlighting their [FIRs (Flight Information Regions)](https://en.wikipedia.org/wiki/Flight_information_region).

{{< image src="/images/accumap/vatspy.png" alt="Screenshot of VAT-Spy" >}}

VAT-Spy, as well as most other VATSIM maps shared a common problem, which was their lack of support for accurately depicting the airspace owned by approach/departure and center/en-route air traffic controllers.

### The problem

As the above screenshot shows, these maps generally highlight an entire FIR when an air traffic controller within that area is connected to the network. This is not always the case on the VATSIM network.

In most cases, these FIRs are split into multiple separate sectors, for example, here is the London FIR:
{{< image src="/images/accumap/fir.png" alt="London FIR" position="center" >}}

London's FIR is further split into smaller, more manageable sectors, such as _"North"_ (in red), _"West"_ (in green), _"Central"_ (in yellow) and _"South"_ (in blue).
ATC also had the option to combine these sectors into _"South Central"_ (_"South"_ and _"Central"_ ) or _"Bandbox"_ (all sectors combined). Some of these sectors could also be split further, but let's not delve too deep into the weeds of UK airspace...

{{< image src="/images/accumap/london_sectors.png" alt="London Airspace Sectors on the VATSIM network" position="center" >}}

These sectors also don't always remain inside of the FIR boundaries. In the above example, the _"North"_ sector leaves a gap north of it's border, and the northern border of the FIR, this is delegated to the Scottish FIR. There is also a bit of the _"West"_ sector surrounding Jersey, and the _"South"_ sector around Dover jutting out into French airspace.

Since the air traffic controllers on the VATSIM network often control one of these sectors at a time, pilots were easily mislead by these outdated map programs into thinking that a controller was covering an entire FIR. This was often the case when a controller had connected to the _"West"_ sector, and pilots would try contacting them from Heathrow, which is well outside of their airspace.

Air traffic controllers would often provide vague explanations of their airspace boundaries to pilots over direct messages. For new pilots, this can be very confusing, and being told that _"you're not in my airspace"_ can sometimes be embarrassing. As for ATC, it's distracting. Not only do they have to manage a complex and busy piece of airspace, but also educate new pilots on their FIRs specific sectors.

Since these older maps weren't capable of depicting an FIRs sub-sectors, the community tried to address this by modifying the FIR boundary data for these programs to at least give a rough idea of where the sectors were. Some may argue this is _"good enough"_, but we thought it looked like shit, made the map harder to read and no longer accurately represented the true FIR boundaries.
This band-aid solution is still in use today.

{{< image src="/images/accumap/vatspy_bodge.png" alt="London Airspace Sectors roughly drawn on VAT-Spy" position="center" >}}

These community made data files were typically distributed via the forums for each region, meaning a data file hosted on the Australian forum might only contain patches for Australia, but not Europe, vice versa.
Without some technical knowledge of the file structure, these files couldn't be combined very easily, which caused a lot of fragmentation in the community.

This fragmentation issue has somewhat been solved in more recent years now that VATSIM have an [official GitHub repo](https://github.com/vatsimnetwork/vatspy-data-project) for these files.

## The beginning of AccuMap

With the above issues in mind, we set out with a few main goals:

1. Accurately display the airspace boundaries for air traffic controllers without making the map look like a mess
2. Store the airspace boundaries in a centralized and publicly accessible source, maintained by the community
3. Build a somewhat modern user interface

### The desktop application

We decided to make AccuMap a desktop application, as it's something most VAT-Spy users were familiar with. That was it really, we didn't have any other reasons.

None of us had any experience in writing desktop applications at the time, only basic HTML, CSS, and JavaScript. With these skills in our toolbox, we decided to use [Electron](https://www.electronjs.org). (As I write this, I keep wondering why we didn't just make it a web app...)

At the time, we weren't familiar with popular UI frameworks such as Angular and React, so we used the tools we were familiar with, and basically built our own UI framework without realizing it! (It wasn't great...)

{{< image src="/images/accumap/prototype.png" alt="AccuMap v1 prototype" >}}

The first prototype was born after a day or two. It wasn't pretty, but it was a start.
The pilot data was sourced from VATSIM's now deprecated WhazzUp feed, and the FIR data was sourced from... I actually don't remember... I think I found a [KML file](https://en.wikipedia.org/wiki/Keyhole_Markup_Language) somewhere online and stuck with it.

### The data

With the application itself under development, it wouldn't be AccuMap without it's sectors.
We started prototyping the sector depiction using KML files drawn by hand using Google Earth, and a text file describing the relationships between controllers and sectors.
This text file was the most important part of AccuMap, as it allowed for sector ownership hierarchies to be accurately depicted on the map.

Creating all these files was tedious work. After slaving away for days drawing sectors ourselves, and not writing any code, we decided to ask the community for help. This truly paid off in spades, as we received **a lot** of expressions of interest.
We ended up with quite a number of contributors from across the globe helping us develop these sectors, spawning our own small community of like-minded people who had a keen interest in airspace.
If you're one of those contributors reading this, you're actually awesome!

Once we had a reasonable amount of sectors drawn for popular areas, and a stable app to show them off, we decided we were ready to release the kraken!

## Version 1

{{< image src="/images/accumap/desktop.png" alt="AccuMap showing Europe with some ATC online" >}}

In August 2017, AccuMap v1 would release! An announcement was made on the official VATSIM forums, as well as a number of other regional forums.
The initial release was very well received, and attracted the attention of FSElite, a small, flight simulation oriented news outlet, who wrote an article about the application.

For us, having our project showcased on a news site was a big deal, and a really big confidence boost!

### Bugs galore

{{< image src="https://c.tenor.com/vlHrAxHFvegAAAAd/here-it-comes-tornado.gif" >}}

Not long after the release of the desktop application, it became clear that it was riddled with issues such as memory leaks, disappearing pilots and air traffic controllers, and a flakey auto-update system that never worked. We often had to tell our users to re-download the installer from our website to receive updates, which was embarrassing to say the least.

This time lapse shows some of the issues which plagued AccuMap. You can notice the aircraft icons sometimes disappear, the airspace sectors sometimes double up or disappear, and the overall experience isn't very smooth.

{{< youtube 83pnatv0eH8 >}}

### Limitations

As we started to add more sectors to our collection, we discovered some limitations. The text file format we used for describing sector hierarchies wasn't quite up to the task of accurately describing the airspace for certain regions.

After months of battling with incoming bugs and feature requests, we still couldn't quite figure out why our auto-update system wasn't working for the majority of users. At this point, our users were getting sick of re-downloading and installing AccuMap every time we had an update. At the same time, we were getting sick of the auto-updater failing to work.

At this point, we were scared that we'd start losing users because of this, so we started to reconsider whether a desktop application was something we wanted to continue with.

## The web application

In December 2017, we began thinking about what we wanted from AccuMap v2. One of the first decisions we made was to use a strongly typed language, as we were sick of using pure JavaScript.
We knew we were doing a web application, so our options at the time were C# with ASP.NET MVC, or Java with Spring.

We eventually decided on C# as it was strongly typed, and had some great features, tooling, and frameworks for building web applications.
As for the frontend, we still didn't know about UI frameworks like React, so we _somehow_ decided to use [Dart](https://dart.dev). I think our reasoning at the time was that it could transpile to JavaScript, and didn't suck as much to write. **This was a horrible idea**.

Languages aside, we also wanted to add improve our airspace sector depiction capabilities, make some quality of life improvements such as flight path trails, unique aircraft icons, and numerous other features and improvements.

## Version 2

{{< image src="/images/accumap/web.png" alt="AccuMap Web Application" >}}

AccuMap v2 eventually released with a similar reception to v1 and addressed most of what it set out to do.
Another time-lapse shows how the experience is much smoother overall, but some issues, such as occasionally disappearing airspace sectors, still plagued the app.

{{< youtube 62Lk9Pyivb8 >}}

## The beginning of the end

### Dart was a horrible choice

First, let's address the elephant in the room. What the hell is Dart?
Dart is a java-like programming language primarily used for [Flutter](https://flutter.dev). It also transpiles to JavaScript so that it can run in a web browser.
Using Dart as our frontend language was a terrible idea. The developer experience might've been _a bit_ better than JavaScript, but we paid the price by worsening our debugging capabilities. Once Dart was transpiled into JavaScript, it was almost impossible to debug. We wasted many hours chasing frontend bugs because of this.

### C# wasn't the _best_ choice

Aside from the frontend, choosing C# also turned out to be a bad decision for AccuMap. Since .NET Core was still in it's infancy at the time, we chose to stick with .NET Framework, which required a Windows server with IIS to run.
Not only was IIS a terrible experience, but our server provider also charged quite a bit of money for the server. We could've gotten a much more powerful linux VM for the same price.

### The final nail in the coffin

One of the main issues with AccuMap was the lack of support from the community. None of us on the AccuMap team were keen on paying for the Windows server to keep it running, and with the community donations slowing down, we decided to pull the plug and shut AccuMap down until we either migrated to ASP.NET Core, or were earning enough from our jobs to be able to pay for the server.

Since then, the original domain name has been taken by scammers, and the source code has remained untouched since 2018.

## Lessons Learned

Looking back on it, we made some pretty _"interesting"_ decisions when designing and developing AccuMap.
Something to bear in mind is that we were all amateur programmers at the time, and we had very little exposure to "real-world" code. We mostly went with whatever worked and stuck with it.

We've come a long way since then and we've learned a lot while building AccuMap.

### Use the right tool for the job

It should've been a web-based application from the very beginning.
We also should've done some research and chosen a popular UI framework such as React, Angular, or Vue, instead of rolling our own.

Another mistake we made was using ASP.NET MVC. To be fair, .NET Core wasn't as mature as it is today, so this was our only choice if we wanted to use C#. That being said, there were other options out there, such as Next.JS, Spring, etc.

### Backwards compatibility matters

Admittedly, when we would update our desktop application, we would often make a breaking change somewhere. This resulted in a terrible experience for our users, as the auto-update system almost never worked as intended.

To keep the costs down, we also took down the server which AccuMap v1 relied on while developing v2, so the desktop app was basically bricked.

### Renew your domain names

If you've got a website that a lot of people visit, don't forget to renew the domain name. The original AccuMap domain name has since fallen into the hands of scammers, and with links to the original site floating around on forums and Discord messages, it doesn't paint a pretty picture.

### Bugs should have priority over features

Despite the fact that AccuMap was riddled with issues, we still pushed forward with new features, and kept adding to a never ending pile of ideas.
We should've addressed the bugs and performance issues before deciding to re-write and add new features.

### Over-hype

Before we even released v1, we spent a bit of time showing AccuMap off on social media, generating a bit of excitement from the community. A new map on the horizon with some pretty new features certainly generated the hype we were expecting, but once users started using it, it became clear to us that many users were disappointed with the amount of bugs and performance issues.

### We didn't really know what we were doing

At the end of the day, AccuMap started as a _"wouldn't this be cool"_ project, which eventually grew into something used by a lot of people in the VATSIM community.
Rather than changing our mindset and focusing on it as a product that people use, we kept treating it as a sandbox where we could experiment, learn, and try out some new ideas.

## The positives

- We built a community
- Thanks to AccuMap, I got my foot in the door into software development
  - I was offered my first .NET job shortly after showing off AccuMap at my first ever tech interview
  - Other AccuMap devs have also gotten their jobs thanks to AccuMap

## The future of AccuMap

It's been a few years since AccuMap officially shut down. Most of the original team still chat regularly, and we've been thinking about what the potential future of AccuMap could look like.

Will there be a v3? Honestly, who knows?
We're not "actively" working on anything at the moment, but we're certainly throwing ideas around, thinking about how a potential v3 might look.
