---
title: "Dallas 2015"
layout: page
---

## Getting ready for the seminar

Candidates are expected to have R and RStudio installed prior to arrival. Although we'll try to help people work through any installation issues, everything will work much more smoothly if you try to install before you get to Dallas. Please contact me using the details in the introductory e-mail you should have received. Basic installation instructions may be found under the [Installations](../Installation) tab of this website.

In addition, you will need to run a short script to install a set of packages that we'll use. Before doing that, here's the scary bit: in order to use the MRMR package, which creates Excel files, you'll need to have Java installed on your machine. Most computers already have this as it's a very common plug-in for internet sites. Visit the [java website](https://www.java.com) for download instructions.

Got java? Good. If you don't, it's not the end of the world. It means that writing to and from Excel- which the MRMR package needs- isn't supported. Everything else that we'll do in the workshop doesn't need java.

When that's done, paste the script below into your R console, one line at a time and hit return after each line. You'll need to be connected to the interweb for this to work. If all goes well, after you execute the `source(tmp)` command, you should see lots of stuff happening. What's happening is that you're installing lots of really cool functionality that's useful for actuaries.

    tmp <- tempfile()
    URL <- "https://raw.githubusercontent.com/PirateGrunt/raw/master/scripts/InstallPackage.R"
    download.file(URL, tmp, method="wget")
    source(tmp)
    unlink(tmp)

Again, if this doesnt work, don't panic. Give me a call and I'll try to sort things out before you get to Texas.

## What's with your hair?

As I write these words, I have a full head of hair and even a beard. By the time the wheels touch down in Texas, all that will be gone. Why? Because I'm participating in a fundraising event for [The St. Baldrick's Foundation](http://www.stbaldricks.org/). St. Baldricks has been raising money for pediatric cancer research for fifteen years. With roots (no pun intended) in the [reinsurance industry](http://www.stbaldricks.org/history), it has grown to become one of the largest providers of clinical research dollars in the world. Along with my friend and colleague Doug Page, I'm proud to serve as a co-organizer of this year's event being held in Raleigh. Last year, we raised just under $350,000 to support children and families suffering from cancer- one of the top ten events in the world. Read my [participant page](https://www.stbaldricks.org/participants/mypage/738777/2015) to learn more.

## What's social hacking?

The CAS wants the RPM and other seminars to be events where actuaries can come together to talk, to learn, to network and have fun. Space will be arranged for anyone at the RPM to bring their curiosity, their skills, their questions, their data and their laptop and hack. After you've learned R, take this opportunity to see it in action in a less structured, less formal environment. Details will be provided as they emerge.