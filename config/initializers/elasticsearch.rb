Elasticsearch::Model.client = Elasticsearch::Client.new(
  url: 'http://elasticsearch:9200',
  log: true,
  transport_options: {
    request: { timeout: 5 }
  }
)