require "elasticsearch"

# this elasticsearch client is nothing but just creating elasticsearch connection while the system started running at first
# this executes once
ELASTIC_CLIENT = Elasticsearch::Client.new(
  url:"https://localhost:9200",
  user: 'elastic',
  password: '4tsRFE9EGrx_j1-gUS1S',
  transport_options: {

    ssl: {verify: false}
  },
  log: true
)