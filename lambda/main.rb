require 'mechanize'
require './slack'

USER_AGENT = 'Mac Safari'.freeze
SEARCH_URL = 'https://www.mercari.com/jp/'.freeze

agent = Mechanize.new { |agent|
  agent.user_agent_alias = USER_AGENT
}

page = agent.get(SEARCH_URL)
form = page.form
product = { name: "Playstation4 本体", min_place: 20000, max_place: 40000 }

form['keyword'] = product[:name]

result = form.click_button

def self.get_href(element)
  element.parent.get_attribute('href')
end

def self.get_product_name(element)
  element.css('.items-box-name').inner_text
end

def self.get_product_price(element)
  element.css('.items-box-price').inner_text
end

result.search('.items-box-body').each do |r|
  puts ("#{get_product_name(r)}の価格は#{get_product_price(r)}でURLは#{get_href(r)}です。")
end
