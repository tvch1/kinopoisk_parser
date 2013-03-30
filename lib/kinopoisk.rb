require 'nokogiri'
require 'httpclient'
require 'kinopoisk/movie'

module Kinopoisk
  SEARCH_URL = "http://www.kinopoisk.ru/index.php?kp_query="

  # Headers are needed to mimic proper request so kinopoisk won't block it
  def self.fetch url
    HTTPClient.new.get url, nil, { 'User-Agent'=>'a', 'Accept-Encoding'=>'a' }
  end
end

String.class_eval do
  def convert_to_array
    self.gsub('...', '').split(', ')
  end
end
