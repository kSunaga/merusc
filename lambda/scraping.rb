require 'httpclient'
require 'pry-byebug'

module Scraping

  END_POINT = 'https://script.google.com/macros/s/AKfycbzUl1CRyPPoasVePuJ-J8GClfXNS2lqS1k1PptdwCEcmez4dQ3N/exec'.freeze

  def self.getKeywords
    client = HTTPClient.new
    client.get(END_POINT, follow_redirect: true)
  end
end
