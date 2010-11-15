# Flyers App

A simple ruby applicaiton to demonstrate a way to get files in and out of couchdb via couchrest

I created this to demonstrate how I wanted something done in another app being built. Hopefully it means they do it right the 1st time.

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
