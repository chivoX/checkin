Checkin API
===================

Checkin is a RoR API, that will allow any client using proper authentication to create users and allow those users to log in time and later on produce reports.
Admin will be able to filter these checkins and produce their own custom reports.

Developed by: `Ivan Granados`

# Requirements

* Ruby 2.6.3
* Rails 5.2.3
* Postgres

# Setting up Database

Copy the existing format of the database.yml and add your custom setup if needed

``
  $ cp config/database.yml.example config/database.yml
``

Then run the following to setup rails db and populate it immediately

`$ rake db:setup`
`$ rake db:migrate`
`$ rake db:seed`

# Getting Started

Before starting to run the application make sure Postgres is up and running

The following command will start the server

``
  $ rails s
``

# Testing

The testing framework that was used is `RSpec`

In order to run test, it is just a matter to run the following command:

``
  $ rspec spec
``

# Endpoints Documentation

* [API Blueprints](https://checkin11.docs.apiary.io)
