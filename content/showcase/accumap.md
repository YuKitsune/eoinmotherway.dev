+++
title = "AccuMap - A popular map for the VATSIM network"
date = "2022-03-13"
cover = "/images/accumap/cover.png"
tags = ["map", "flight simulation", "vatsim"]
keywords = ["accumap", "vatsim", "map"]
draft = true
+++

In 2017, a small group of flight simulation enthusiasts from the [VATSIM network](https://vatsim.net) came together to develop a new map which could accurately display all pilots and air traffic controllers connected to the network.

Maps like this have existed for a long time, [VAT-Spy](https://vatspy.rosscarlson.dev) being the most popular map still in use today.
These maps all shared a common problem, which was their lack of support for accurately depicting the airspace owned by air traffic controllers.

Air traffic controllers on the VATSIM network would often need to explain to pilots how these maps weren't showing their "real" coverage, and had to resort to vague explanations in an attempt to teach the pilot where their airspace begins and ends. For new pilots, this can be very confusing, and getting told by ATC that "you're not in my airspace" can sometimes be embarrassing.

These programs often shipped with out-of-date data right out of the box, which meant that users would have to manually install new data sets by downloading them from the internet, navigating into the program files, and replacing a number of `.dat` files. These files weren't hosted or maintained by a central authority, meaning one file might have updates for Australia, while another might have updates for Europe. These files couldn't be combined without some technical knowledge, and caused quite a lot of fragmentation in the community.

With these issues in mind, the team set out with two main goals:

1. Accurately display air traffic controller sector boundaries
2. Store the air traffic controller boundaries in a centralized and publicly accessible source, maintained by the community

# Version 1
![Earliest known screenshot of AccuMap (pre-alpha)](images/accumap/v1_Early)

The first version of AccuMap officially released on the 23rd of August 2017
