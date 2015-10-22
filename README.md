Barebones
===
[![Gem Version](https://badge.fury.io/rb/barebones.svg)](https://badge.fury.io/rb/barebones)  
Barebones is my personal base Rails application. After developing a
couple of Rails applications, I thought that there were some common
gems and patterns that would be nice to have out of the box.

Installation
---
Install the gem:  

    gem install barebones

Then run:  

    barebones [AppName]

#### Flags
If you don't like using any of the below gems or configurations for whatever reason, you can skip them:
* --skip-api
* --skip-sorcery
* --skip-minitest
* --skip-resque
* --skip-carrierwave

For example:

    barebones [AppName] --skip-api --skip-sorcery

Gemfile
---
Barebones' [Gemfile](templates/Gemfile.erb) includes various preconfigured gems such as:
####File Uploading
* [Carrierwave](https://github.com/carrierwaveuploader/carrierwave) for file uploading
* [Fog](https://github.com/fog/fog) for AWS/Google cloud storage
* [MiniMagick](https://github.com/minimagick/minimagick) for image cropping/resizing and all that good stuff

####Background Processing
* [Resque](https://github.com/resque/resque) for background workers
* [Resque-Scheduler](https://github.com/resque/resque-scheduler) for queueing workers in the future

####Database
* [Postgres](https://rubygems.org/gems/pg/versions/0.18.3)

####Dev/Testing
* [Byebug](https://github.com/deivid-rodriguez/byebug) for debugging
* [Pry Byebug](https://github.com/deivid-rodriguez/pry-byebug) for debugging background jobs
* [Web Console](https://github.com/rails/web-console) for debugging views
* [Quiet Assets](https://github.com/evrone/quiet_assets) for muting the Rails asset pipeline log
* [Awesome Print](https://github.com/michaeldv/awesome_print) for pretty printing command line objects

####Testing
* [Minitest](https://github.com/blowmage/minitest-rails) for TDD/BDD
* [Minitest Reporters](https://github.com/kern/minitest-reporters) for customizable Minitest output formats

####Authentication
* [Sorcery](https://github.com/NoamB/sorcery) for user authentication

####API
* [Jbuilder](https://github.com/rails/jbuilder) for building JSON structures
* [oj](https://github.com/ohler55/oj) for faster JSON parsing (and a faster Jbuilder)
* [oj_mimic_json](https://github.com/ohler55/oj_mimic_json)
* [MultiJSON](https://github.com/intridea/multi_json)

Design Patterns
---
* Services (Pre-made folder)
* [Custom Decorator Class](templates/barebones_decorator.rb.erb) (A custom subclass of SimpleDelegator)

API
---
* [Routes](templates/Gemfile.erb) with API subdomain and version namespacing
* [ApiConstraints](templates/api_constraints.rb.erb) for API version control
* [Configurations/Ping endpoint](templates/configs_controller.rb) to test that the API works :)

Dependencies
---
Barebones requires the latest version of Ruby (2.2.3), Rails (4.2.3), and
PostgreSQL (9.4) on your local machine.
 
License
---
Barebones is copyright © 2015 Danny Yu.  
It is free software, and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: LICENSE