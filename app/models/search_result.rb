class SearchResult < ApplicationRecord
  after_create :send_slack_notification

  def send_slack_notification
    options = {
      pretext: '',
      username: 'scraping_sample',
      icon_emoji: ':ghost:',
      attachments: {
        color: '#96d0e8',
        fallback: nil,
        fields: [
          {
            title: 'description',
            value: description,
            short: false
          },
        ],
        text: title,
        title: "\##{id} #{title}",
        title_link: url,
      }.compact
    }
    Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']).ping('', options) if ENV['SLACK_WEBHOOK_URL'].present?
  end
end
