
Elasticsearch::Model.client = Elasticsearch::Client.new url: ENV["URL"]
Searchkick.client = Elasticsearch::Client.new(hosts: ENV["URL"], retry_on_failure: true, transport_options: {request: {timeout: 250}})