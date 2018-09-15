require './config/initializers.rb'

def notify(message)
  return if ENV['SLACK_WEBHOOK_URL'].blank?
  Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']).ping(message, {})
end

notify('スクレイピング開始')
scraper = GoogleScraper.new
scraper.search('スクレイピング')
5.times do |_i|
  scraper.fetch_results
  sleep(1)
  scraper.move_next_page
end
scraper.quit
notify('スクレイピング終了')
