require 'nokogiri'
require 'httpclient'
require 'kinopoisk/movie'
require 'kinopoisk/search'
require 'kinopoisk/person'

module Kinopoisk
  SEARCH_URL = "http://www.kinopoisk.ru/index.php?kp_query="

  # Headers are needed to mimic proper request so kinopoisk won't block it
  def self.fetch url
    HTTPClient.new.get url, nil, { 'User-Agent'=>'a', 'Accept-Encoding'=>'a' }
  end

  def self.parse url
    page = fetch url
    page.status == 200 ? Nokogiri::HTML(page.body.encode('utf-8')) : raise
  end
end
