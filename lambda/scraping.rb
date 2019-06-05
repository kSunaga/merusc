require 'mechanize'
require './api'
require 'yaml'

setting = YAML.load_file('./settings.yml')

USER_AGENT = 'Mac Safari'.freeze
SEARCH_URL = setting['search_url'].freeze

module Scraping

  def self.getResponse
    agent = Mechanize.new {|agent|
      agent.user_agent_alias = USER_AGENT
    }
    page = agent.get(SEARCH_URL)
    form = page.form
    results = []
    products = JSON.parse(::Api.getKeywords.body)
    products["items"].each do |p|
      form['keyword'] = p["keyword"]
      result = form.click_button
      result.search('.items-box-body').each do |r|
        results.push("#{get_product_name(r)}の価格は#{get_product_price(r)}でURLは#{get_href(r)}です。") if sold_out?(r) && just?(r, p)
      end
    end
    results
  end

  def self.get_href(element)
    element.parent.get_attribute('href')
  end

  def self.get_product_name(element)
    element.css('.items-box-name').inner_text
  end

  def self.get_product_price(element)
    convert_price_to_int(element.css('.items-box-price').inner_text)
  end

  def self.convert_price_to_int(element)
    element.delete('¥').delete(',').to_i
  end

  def self.sold_out?(element)
    element.parent.search('.item-sold-out-badge')
  end

  def self.just?(element, product)
    product['min_place'] < get_product_price(element) && get_product_price(element) < product['max_place']
  end
end
