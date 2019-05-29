require 'rubygems'
require 'mechanize'

agent = Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac Safari'
}

page = agent.get("https://www.mercari.com/jp/")
form = page.form
product = { name: "Playstation4", place: 30000 }

form['keyword'] = product[:name]

result = form.click_button

result.search('.items-box-body').each do |r|
   puts ("#{r.css('.items-box-name').inner_text}の価格は#{r.css('.items-box-price').inner_text}です。")
end
