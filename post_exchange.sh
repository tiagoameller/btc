curl https://api.coindesk.com/v1/bpi/currentprice.json > /tmp/btc.json
curl -X POST -H "Content-Type: application/json" -d @/tmp/btc.json http://localhost:3000/api/v1/exchange_logs
