# A application for multiplateform for study project in Valladolid

This application contains a home page to redirect toward 4 views:
- [Vodcast](#vodcast)
- [Resources](#resources)
- [Calculator](#calculator)
- [Figures](#figures)


I create a web site to interact with this application on [https://valladolid.alwaysdata.net](https://valladolid.alwaysdata.net/videos.php).

This application is available on [my Github](https://github.com/exblematique/valladolid).

## Vodcast

This Widget have 2 steps.

### Step 1: List of videos

This page displays the list of videos available. There are 2 parts :
- Local videos which contains all videos available in res/ folders in this Flutter application
- Distant videos on [web server](https://valladolid.alwaysdata.net/videos/)

When views starts, this view will download the file [videos.php](https://valladolid.alwaysdata.net/videos.php) on the root of server.
This contains a JSON object. This is a list with all videos available on the server.

User can be pressed a button to watch the corresponding video.

### Step 2: Watch video

When this view is started, a controller is created.
The method to initialize this depends if video is local or distant.

When video is ready, the user can watch it. There is a floating button to pause the video.

## Resources

This view displays a web page from [https://valladolid.alwaysdata.net](https://valladolid.alwaysdata.net/). User can be navigate on this but stay on this application

## Calculator

This view enables to user to calculate him Okula. Data to calculate this are official data from [Gastro website](http://www.gastro.org/guidelines).

## Figures

This views displays figures available for understand courses. A drawer is created to enable to switch between all figures and back on the previous page.