# Trend Tracker

Trend Tracker visualises social media trends on a map in real time.


You can access the already deployed application from this URL:  
[https://trendtracker.herokuapp.com/](https://trendtracker.herokuapp.com/)

## Setup

This project was made using [IntelliJ IDEA 2021.1](https://www.jetbrains.com/idea/download/#section=windows) and tested using [Google Chrome](https://www.google.com/intl/en_uk/chrome/) browser. The Project SDK uses Ruby v2.5.8 and Rails v5.2.

If you choose to run this on your local machine, there are steps to starting the web server using IntelliJ IDEA [here](https://www.jetbrains.com/help/idea/get-started.html#interpreter) where you can find the links to install the correct Ruby on Rails version.  

When running the database, make sure to initialise the database location seed by running:
```
rails db:seed
```
This will ensure that the locations that are checked for trend data are properly initialised.
