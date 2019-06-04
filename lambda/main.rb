require 'mechanize'
require './slack'
require './scraping'

USER_AGENT = 'Mac Safari'.freeze
SEARCH_URL = 'https://www.mercari.com/jp/'.freeze

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

agent = Mechanize.new {|agent|
  agent.user_agent_alias = USER_AGENT
}

page = agent.get(SEARCH_URL)
form = page.form
products = JSON.parse(Scraping.getKeywords.body)
products["items"].each do |p|
  form['keyword'] = p["keyword"]

  result = form.click_button

  result.search('.items-box-body').each do |r|
    if p["min_place"] < get_product_price(r) && get_product_price(r) < p["max_place"]
      puts ("#{get_product_name(r)}の価格は#{get_product_price(r)}です。")
    end
  end
end
