# README

## BTC. Sample Rails 6.1 project.

### Features
* API to post BTC exchange values for USD, GBP and EUR
* Shows last 30 days, 24 hours and last hour average rates
* ActionCable for updating frontend when a new exchange value is posted to API
* Abstractions for Rates::Average and Rates::MinMax
* Service objects for generating backend info on frontend demand

### How to run it
1. Clone this repo
2. run `bundle`
3. run `yarn`
4. create and seed database: `rake db:drop db:create db:migrate db:seed`
5. start application: `rails s`
6. visit `http://localhost:3000`

**Note data:**

Some random BTC values are created when seeding, but they quickly will become obsolete.
So, you can post new data to feed the database. A simple and effective way is run this pair of `curl`:

`curl https://api.coindesk.com/v1/bpi/currentprice.json | curl -X POST -H "Content-Type: application/json" -d @- http://localhost:3000/api/v1/exchange_logs`

This will download real time data from [Coindesk](https://coindesk.com) and push it to this app API

Thanks to websockets powered by ActionCable, frontend is updated in realtime

