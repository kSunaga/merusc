require 'rubygems'
require 'mechanize'

agent = Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac Safari'
}

page = agent.get("https://www.mercari.com/jp/")
form = page.form
form['keyword'] = "Playstation4"

result = form.click_button
pp result

#form.q = "PlayStation4"

# result = agent.submit(form, form.buttons.first)
# puts result
# contact = page.link_with(text: "採用情報").click

# contact.links.each do |link|
#   puts link.text
# end
