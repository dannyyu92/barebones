Barebones
===
Barebones is my personal base Rails application. After developing a
couple of Rails applications, I thought that there were some common
gems and patterns that would be nice to have out of the box.

Installation
---
For now, just run ./bin/barebones <AppName>

Gemfile
---
Barebones includes various preconfigured gems such as:
####File Uploading
* Carrierwave
* Fog (Configured for both Google Cloud and AWS S3)
* Mini Magick

####Background Processing
* Resque
* Resque Scheduler

####Database
* Postgres
* Mongoid

####Dev/Testing
* Byebug
* Spring
* Web console
* Quiet Assets
* Awesome Print

####Testing
* Minitest Reporters
* Mini Backtrace
* Guard Minitest
* Factory Girl Rails

####Authentication
* Sorcery

Design Patterns
---
* Services (Pre-made folder)
* Decorator (Subclass of SimpleDelegator)

Dependencies
---
Barebones requires the latest version of Ruby (2.2.2), Rails (4.2.3), and
PostgreSQL (9.4) on your local machine.
 
License
---
Barebones is copyright © 2015 Danny Yu.