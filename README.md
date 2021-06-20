# README

## BTC. Sample Rails 6.1 project.

### Features
* API to post BTC exchange values for USD, GBP and EUR
* Shows last 30 days, 24 hours and last hour average rates
* ActionCable for updating frontend when a new exchange value is posted to API
* Abstractions for Rates::Average and Rates::MinMax
* Service objects for generating backend info on frontend demand
