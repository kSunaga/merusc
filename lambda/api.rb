require 'httpclient'
require 'yaml'

setting = YAML.load_file('./settings.yml')
ENDPOINT = setting['endpoint'].freeze

module Api

  def self.getKeywords
    client = HTTPClient.new
    client.get(END_POINT, follow_redirect: true)
  end
end
