require 'slack-notifier'

module Slack
  WEBHOOK_URL = 'https://hooks.slack.com/services/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'.freeze

  def self.post_message(message)
    notifier = Slack::Notifier.new WEBHOOK_URL
    notifier.ping message.join("\n")
  end
end
