# XKCD Iterator 

## Purpose
This project is an attempt is to solve a problem of mine, get my daily XKCD fix.

Everyday subscribers receive an email with a comic from the notorious webcomic https://www.xkcd.com/ starting from number one.

It is also a way to use my favorite framework [Ruby on Rails](https://rubyonrails.org/) while demonstrating how I am handle certain aspects like 
* API token management
* DB credentials
* corn jobs
* server deployments
* error handling
 
Check it out here 
[xkcd-iterator](http://xkcd-iterator.alex-web.gr/)

## Usage
If you need to set it up locally you will need to generate new credentials `bin/rails credentials:init` and create a file under `config/application.yml`
with the following structure 

    development:
      SECRET_KEY_BASE: 
      GOOGLE_CLIENT_ID: 
      GOOGLE_CLIENT_SECRET: 
 
    test:
      SECRET_KEY_BASE: 
 
    production:
      SECRET_KEY_BASE:
      
then create the databases `bundle exec rake db:create`

load the schema `bundle exec rake db:schema:load`

start the server `rails s` or `unicorn`
 
it is possible to run `bundle exec rails <command>` using the Rake Proxy that was introduced in version 5 
 
## TODO
Send emails with ActiveJob in order to deliver_later using sidekiq and Redis

## Contribute 
Did you spot something that doesn't look quite ? Do you want to add a new feature ?
Then feel free to open an [issue](https://github.com/alexwebgr/xkcd-iterator/issues) or even create
a [pull request](https://github.com/alexwebgr/xkcd-iterator/pulls).
