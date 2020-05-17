class GoogleScraper
  HOST = 'https://www.google.co.jp/'.freeze
  GOOGLE_SEARCH_ELEMENT_NAME = 'q'

  def initialize
    chrome_capabilities = Selenium::WebDriver::Remote::Capabilities.chrome
    @driver = Selenium::WebDriver.for(
      :remote,
      url: "http://#{ENV['SELENIUM_HOST']}:4444/wd/hub",
      desired_capabilities: chrome_capabilities
    )
  end

  def doc
    Nokogiri::HTML.parse(@driver.page_source, nil, nil)
  end

  def search(keyword)
    @driver.get(HOST)
    element = @driver.find_element(name: GOOGLE_SEARCH_ELEMENT_NAME)
    element.send_keys(keyword)
    element.submit
  end

  def fetch_results
    nodes = doc.xpath('//*[@id="rso"]/div')
    nodes.each do |node|
      x = SearchResult.create!(
        description: node.css('.st').first&.text,
        title: node.css('h3').first.text,
        url: node.css('a').first.attributes["href"].value.slice(0, 100)
      )
      p x
    end
  end

  def move_next_page
    path = doc.xpath('//*[@id="pnnext"]').last.attributes["href"].value
    @driver.get(HOST + path)
  end

  def quit
    @driver.quit
  end
end
