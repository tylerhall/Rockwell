# Rockwell

Rockwell, named after [the company](http://en.wikipedia.org/wiki/Rockwell_International) that built the first GPS satellite, is a [Fire Eagle](http://fireeagle.yahoo.net/) inspired, personal replacement for [Google Latitude](http://www.google.com/mobile/latitude/).

The project is split into two components:

* An iPhone app that runs in the background on your iPhone and automatically stores your location history in its server-side counterpart.
* A PHP/MySQL based web application that stores your location history, allows you to search your previous locations by date and by location, and provides a simple location brokerage service to share your current location with other services/people.

## What is it?

**tl;dr** Rockwell is a self-hosted Google Latitude replacement for people who don't want Google to store their location data.

I love that so much of my life's metadata is always with me and searchable. My email, calendar, text messages, photos, music, documents - they're all available and at my fingertips thanks to my iPhone. I would love to have my location history available, too. Google Latitude does a really great job at making that dataset a reality, but I'm not comfortable having Google store my every move. So I built Rockwell as a replacement that keeps me in control of my personal data.

The iPhone app automatically uploads your location to the server even when the app is in the background, without any noticable effect on your phone's battery life. From the web app or your phone, you can view your location history and search it by date or by location. Further, the web app will let you share you current coordinates, city, state, or country via an obfuscated short url. You could use that data, for example, to show your current city on your blog without giving away your actual, specific location.

## Install

### Web App
The web app requires PHP 5 and MySQL 5. Simply upload the contents of the `www` directory to your web server and visit the `/install/` url in your browser to get started.

### iPhone App

The iPhone app requires iOS 6. Currently, you'll need to download the source and build it yourself. Once the app is more complete I plan on releasing it for free in the App Store.
