# Flyers App

A simple ruby applicaiton to demonstrate a way to get files in and out of couchdb via couchrest

I was having trouble verifying that sendgrid was working with an application that I wasn't developing.
Needed a simple app that I could redirect specific URI's to, that could give tell me sendgrid was doing what is was suppose to.
The application is being developed in Java and is running in Tomcat fronted by nginx.
So all I had to do was put a location rule in nginx and proxy the request to this app instead of Tomcat.

## Running

      git clone http://github.com/SoreGums/flyers.git
      cd flyers
      bundle install
      cp config/database.sample.rb config/database.rb
      nano config/database.rb
      bundle exec padrino rake seed
      bundle exec padrino start

That's it, open your browser and login as the admin user you just created and read the home page :)

## Notes

* This works for what it is suppose to do, you deviate from the path, might break...
