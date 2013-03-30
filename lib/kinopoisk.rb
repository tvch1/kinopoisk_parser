require 'nokogiri'
require 'open-uri'
require 'kinopoisk/movie'

module Kinopoisk
  SEARCH_URL = "http://www.kinopoisk.ru/index.php?kp_query="

  # Headers are needed to mimic proper request so kinopoisk won't block it
  def self.fetch url
    open url, 'User-Agent'=>'Mozilla', 'Accept-Encoding'=>'a'
  end
end
