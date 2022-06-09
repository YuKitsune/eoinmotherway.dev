+++
title = "AccuMap"
summary = "A modern and accurate map for the VATSIM network."
date = "2022-03-13"
cover = "/images/accumap/cover.png"
keywords = ["accumap", "vatsim", "flight simulation", "map"]
author = "Eoin Motherway"
+++

## What was AccuMap?

AccuMap was a relatively popular live map of the [VATSIM network](https://vatsim.net), renowned for it's accurate depiction of air traffic control (ATC) sectors, and modern user interface.
Myself, along with a number of other VATSIM members threw it together in mid 2017 as a _"wouldn't this be cool"_ project, which eventually gained the attention of the broader VATSIM community.
This lead us to release the map as a desktop application which later evolved into a web based application.

If you're interested to learn about AccuMap's story from it's conception to it's demise, then read on!

## What is VATSIM?

VATSIM is an online air traffic simulation network, connecting people from around the world flying online or acting as virtual air traffic controllers.
Air traffic control is available in VATSIM's communities throughout the world, operating as close as possible to the real-life procedures and utilizing real-world weather, airport, and route data.

On VATSIM, users can join people on the other side of the world to fly and control, with nothing more than a home computer.

### VATSIM maps

Similar to websites such as [Flightradar24](https://flightradar24.com), [FlightAware](https://flightaware.com) and [Plane Finder](https://planefinder.net), many map applications have been developed for the VATSIM network, not only showing where people are flying, but also where people can be found providing air traffic control services.

VATSIM's most popular map, [VAT-Spy](https://vatspy.rosscarlson.dev), is recognized by the community as the de-facto map of VATSIM, as it's lightweight, easy to use, and generally does a good job at showing ATC.

{{< image src="/images/accumap/vatspy.png" alt="Screenshot of VAT-Spy" >}}

VAT-Spy, as well as most other VATSIM maps shared a common problem, which was their lack of support for accurately depicting the airspace owned by approach/departure, and center/en-route air traffic controllers.

### The problem with VATSIM maps

As the above screenshot shows, these maps typically highlight an entire [Flight Information Region](https://en.wikipedia.org/wiki/Flight_information_region) (FIR) when an air traffic controller within that area is connected to the network. On the VATSIM network, this can sometimes lead to confusion, as these FIRs are typically split up into multiple different sub-sectors.

{{< image src="/images/accumap/fir.png" alt="London FIR" position="center" >}}

The above image shows the London FIR. This FIR is further split into smaller, more manageable sectors, such as _"North"_ (in red), _"West"_ (in green), _"Central"_ (in yellow), and _"South"_ (in blue).
ATC also has the option to combine these sectors into _"South Central"_ (_"South"_ and _"Central"_ ) or _"Bandbox"_ (all sectors combined). Some of these sectors could also be split further, but let's not delve too deep into the weeds of UK airspace...

{{< image src="/images/accumap/london_sectors.png" alt="London Airspace Sectors on the VATSIM network" position="center" >}}

These sectors also don't always remain inside of the FIR boundaries. In the above example, the _"North"_ sector leaves a gap north of it's border, and the northern border of the FIR, this is delegated to the Scottish FIR. There is also a bit of the _"West"_ sector surrounding Jersey, and the _"South"_ sector around Dover jutting out into French airspace.

Since the air traffic controllers on the VATSIM network often control one of these sectors at a time, pilots were easily mislead by programs like VAT-Spy into thinking that a controller was covering a much larger area than they really were.

Air traffic controllers would often provide pilots with vague explanations of their airspace boundaries via direct messages. For new pilots, this can be very confusing, and sometimes embarrassing. For ATC, it's distracting. Not only do they have to manage a complex and busy piece of airspace, but also educate new pilots on their FIRs specific sectors.

Since these older maps weren't capable of depicting an FIRs sub-sectors, the community tried to address this by modifying the FIR boundary data for these programs to at least give a rough idea of where the sectors were. Some may argue this is _"good enough"_, but we thought it didn't look good, made the map harder to read, and no longer accurately represented the true FIR boundaries.
This band-aid solution is still in use today.

{{< image src="/images/accumap/vatspy_bodge.png" alt="London Airspace Sectors roughly drawn on VAT-Spy" position="center" >}}

These community made data files were typically distributed via the forums for each region, meaning a data file hosted on the Australian forum might only contain patches for Australia, but not Europe, vice versa.
Without some technical knowledge of the file structure, these files couldn't be combined very easily, which caused a lot of fragmentation in the community.

This fragmentation issue has somewhat been solved in more recent years now that VATSIM has an [official GitHub repo](https://github.com/vatsimnetwork/vatspy-data-project) for these files.

## The beginning of AccuMap

With the above issues in mind, we set out with a few main goals:

1. Accurately display the airspace boundaries for connected air traffic controllers
2. Store the airspace boundaries in a centralized, and publicly accessible source, maintained by the community
3. Build a somewhat modern user interface

### Prototyping

We decided to make AccuMap a desktop application, as it's something most VAT-Spy users were familiar with.
None of us had any experience in writing desktop applications at the time, only basic HTML, CSS, and JavaScript. With these skills in our toolbox, we decided to use [Electron](https://www.electronjs.org).

We also weren't familiar with any of the popular UI frameworks at the time such as Angular, and React, so we ended up building our own UI framework without realizing it! (It wasn't great...)

{{< image src="/images/accumap/prototype.png" alt="AccuMap v1 prototype" >}}

The first prototype was born after a day or two. It wasn't pretty, but it was a start.
The pilot data was sourced from VATSIM's now deprecated WhazzUp feed, and the FIR data was originally sourced from VAT-Spy, but modified slightly to better represent the real FIR boundaries.

### Sourcing the airspace data

With the application itself under development, it wouldn't be AccuMap without it's sectors.
We started prototyping the sector depiction system using [KML files](https://en.wikipedia.org/wiki/Keyhole_Markup_Language) drawn by hand using Google Earth, and a text file describing the relationships between controllers and sectors.
This text file was the most important part of AccuMap, as it allowed for sector ownership hierarchies to be more accurately depicted on the map.

Creating all these files was tedious work. After slaving away for days drawing sectors ourselves, and not writing any code, we decided to ask the community for help. This truly paid off in spades, as we received **a lot** of expressions of interest.
We ended up with quite a number of contributors from across the globe helping us develop these sectors, spawning our own small community of like-minded people who had a keen interest in airspace.
If you're one of those contributors reading this, you're actually awesome!

Once we had a reasonable amount of sectors drawn for popular areas, and a stable app to show them off, we decided we were ready to release the kraken!

## Initial release

{{< image src="/images/accumap/desktop.png" alt="AccuMap showing Europe with some ATC online" >}}

In August 2017, AccuMap v1 would release! An announcement was made on the official VATSIM forums, as well as a number of other regional forums.
The initial release was very well received, and attracted the attention of [FSElite](https://fselite.net), a small, flight simulation oriented news outlet, who wrote an article about the application.

For us, having our project showcased on a news site was a big deal, and a really big confidence boost!

### More bugs than we thought

Not long after the release of the desktop application, it became clear that it wasn't as stable as we originally thought it was.
The program riddled with issues such as memory leaks, performance issues, disappearing pilots and air traffic controllers, and a flakey auto-update system that never worked. We often had to tell our users to re-download the installer from our website to receive updates, which was embarrassing to say the least.

This time lapse shows some of the issues which plagued AccuMap. You can notice the aircraft icons sometimes disappear, the airspace sectors sometimes double up or disappear, and the overall experience isn't very smooth.

{{< youtube 83pnatv0eH8 >}}

### Maybe desktop wasn't the best choice

After months of battling with incoming bugs and feature requests, we started to realize the issues associated with maintaining a desktop application.
We weren't able to make breaking changed on the server to update things such as our ATC sector definition file format, as some users will have older versions of the application installed.
We also struggled with implementing an automatic update system. We made many attempts to implement one, but didn't find much success.

At this point, the list of bugs was getting bigger and bigger, and we were getting concerned that that we'd start losing users, so we started to reconsider whether a desktop application was something we wanted to continue with.

## Attempt #2

In December 2017, we began thinking about what we wanted from AccuMap v2. One of the first decisions we made was to use a strongly typed language, as we were sick of using pure JavaScript.
We knew we were going to write a web application, so our options at the time were C# with ASP.NET MVC, or Java with Spring.

We eventually decided on C# as it was strongly typed, and had some great features, tooling, and frameworks for building web applications.
As for the frontend, we still didn't know about UI frameworks, and we weren't happy using pure JavaScript. We eventually stumbled on [Dart](https://dart.dev), which had similar syntax to Java, and could transpile to JavaScript for use in web browsers.

Aside from a complete rewrite, we also wanted to add improvements our airspace sector depiction capabilities, make some quality-of-life improvements such as flight path trails, unique aircraft icons, and numerous other features and improvements.

## Version 2

{{< image src="/images/accumap/web.png" alt="AccuMap Web Application" >}}

AccuMap v2 eventually released with a similar reception to v1, and addressed most of what it had set out to do.

It was significantly more stable, added a number of new features, and looked much cleaner than v1.
This time-lapse shows how the experience is much smoother overall, but some issues were still present, such as occasionally disappearing airspace sectors.

{{< youtube 62Lk9Pyivb8 >}}

## Lessons Learned

Looking back on it, we made some pretty _"interesting"_ decisions when designing and developing AccuMap.
Something to bear in mind is that we were all amateur programmers at the time, and we had very little exposure to "real-world" code. This was our first ever major software project (first ever project for some of us), so we were all developing some core skills, learning new things, and having a bit of fun in the process.

We've come a long way since then and we've learned a lot from the mistakes we made while building AccuMap.

### Planning is super important

When we started AccuMap, we jumped straight into the code and got a prototype going. From there, we never really took a step back and developed any kind of plan. We kept adding more and more features until we were happy with it, and released it into the wild.

Without a plan, we were highly susceptible to scope creep, and could easily lose track of any in-progress work.

In retrospect, we should've put together some kind of plan, whether it be a todo list in a markdown file, or cards on a kanban board like Trello. Anything would've been better than nothing.

### Know your tools

When it came time to choose tools such as languages and frameworks, we really didn't do any research. We ended up making some poor decisions, which ultimately made AccuMap hard to maintain, and a pain to run in production.

Rather than building our own UI framework, we should've looked into something vetted like Angular, React, or Vue. Had we chosen one of those frameworks, we wouldn't have wasted our time, would've been more productive, and would've had a chance to learn a new tool.

We also should've considered the cons of the languages we chose, rather than focusing on the pros.

Dart wasn't designed with web browser support in mind. It was designed primarily for [Flutter](https://flutter.dev). Because of this, we found it quite difficult to debug, and struggled to find documentation and 3rd party libraries for our use case. In retrospect, we should've chosen TypeScript.

While C# is a fantastic language, we chose it at a time when it's linux support wasn't quite up to the task of what we wanted to do. Because of this, we required a Windows server with IIS to run it in production, which was a pain to use, and accounted for almost 50% of the running costs.

### Learn to prioritize

Bugs are inevitable, especially for a project built by a bunch of amateurs. They can significantly affect the user experience, or even render the application unusable in some cases.

When bugs are found, it's important to prioritize them correctly.
Small bugs that aren't encountered very often, and aren't as annoying can be addressed later. Big bugs that occur often, and affect the user experience of the application should be addressed ASAP.

We made the mistake of not prioritizing bugs at all, instead focusing on introducing features into AccuMap. This quickly lead to new bugs being introduced, adding to an ever growing list of bugs, and a sharply declining user experience.

## The positives

Despite all of the issues we faced during AccuMaps lifetime, it wasn't all negatives.

Thanks to AccuMap, we built a tight-knit community of like-minded people with a passion for airspace, and technology, which is still active today!
AccuMap also played a key role in advancing our career as developers. We learned a ton of things from the project, including plenty of _"what not to do"_'s. Some of us also used AccuMap on our resumes, which was very beneficial when searching for some of our first jobs in software.

## The future of AccuMap

It's been a few years since AccuMap officially shut down. Most of the original team still chat regularly, and we've been thinking about what the potential future of AccuMap could look like.

Will there be a v3? Honestly, who knows?
We're not _"actively"_ working on anything at the moment, but we're certainly throwing ideas around, thinking about what a potential v3 might look like.
