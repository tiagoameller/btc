# let's add 24 hour data to our database.
# ASSUMPTION 1: btc.json is located on Rails.root
# ASSUMPTION 2: btc.json contains samples for every 30 secs.
# timestamps in btc.json will be ignored: we'll take current timestamp - 24h as starting point
#

json = JSON.parse(File.read(Rails.root.join('btc.json')))

updated = 1.day.ago
ExchangeLog.connection.transaction do
  json.each do |exchange|
    ExchangeLog.create(
      updated: updated,
      usd_rate: exchange.dig('bpi', 'USD', 'rate_float')&.to_f || 0,
      gbp_rate: exchange.dig('bpi', 'GBP', 'rate_float')&.to_f || 0,
      eur_rate: exchange.dig('bpi', 'EUR', 'rate_float')&.to_f || 0
    )
    updated += 30.seconds
  end
end
