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

# 配列
# products = Scraping.getKeywords

agent = Mechanize.new {|agent|
  agent.user_agent_alias = USER_AGENT
}

page = agent.get(SEARCH_URL)
form = page.form
products = {name: "ipad pro", min_place: 20000, max_place: 40000}

# if products.nil?
  form['keyword'] = products[:name]
# else
#   products.each do |k|
#     form['keyword'] = k[:name]
#   end
# end
result = form.click_button

result.search('.items-box-body').each do |r|
  if products[:min_place] < get_product_price(r) && get_product_price(r) < products[:max_place]
    puts ("#{get_product_name(r)}の価格は#{get_product_price(r)}です。")
  end
end
