require 'slack-notifier'
require 'yaml'

setting = YAML.load_file('./settings.yml')
WEBHOOK_URL = setting['webhook_url'].freeze

module Slack

  def self.post_message(message)
    notifier = Slack::Notifier.new WEBHOOK_URL
    notifier.ping message.join("\n")
  end
end
