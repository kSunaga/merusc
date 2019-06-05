require './scraping'
require './slack'

def lambda_handler(event:, context:)
  Slack.post_message(Scraping.getResponse)
end
