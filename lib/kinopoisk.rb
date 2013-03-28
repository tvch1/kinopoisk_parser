require 'nokogiri'
require 'net/http'
require 'kinopoisk/movie'

module Kinopoisk
  def self.fetch url
    url      = URI.parse url
    request  = Net::HTTP.new url.host, url.port
    response = request.get url.path, {'User-Agent' => 'Mozilla'}
  end
end
