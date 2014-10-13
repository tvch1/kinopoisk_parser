require 'nokogiri'
require 'httpclient'
require 'kinopoisk/movie'
require 'kinopoisk/search'
require 'kinopoisk/person'
require 'kinopoisk/trailer'

module Kinopoisk
  SEARCH_URL = "http://www.kinopoisk.ru/index.php?kp_query="
  NotFound   = Class.new StandardError
  Empty      = Class.new StandardError

  # Headers are needed to mimic proper request so kinopoisk won't block it
  def self.fetch(url)
    config = YAML.load_file('./kinopoisk_parser.yml')
    server_id = config['id'].to_i
    config['id'] = (server_id + 1) % 5
    File.open './kinopoisk_parser.yml', 'w' do |file|
      file.write config.to_yaml
    end
    client = HTTPClient.new
    i = 0
    response = nil
    while  i < 10 && response.try(:code) != 200
      response = client.get("http://kinopoisk-parser-#{server_id}.herokuapp.com/page?url=#{url}", nil , { 'User-Agent'=>'a', 'Accept-Encoding'=>'a' })
      print "\nhttp://kinopoisk-parser-#{server_id}.herokuapp.com/page?url=#{url} - #{response.code}"
      i += 1
    end

    Marshal.restore(JSON.parse(response.body)['message'].encode('Windows-1251'))
  end

  def self._fetch(url)
    response = HTTPClient.new.get("#{url}", nil , { 'User-Agent'=>'a', 'Accept-Encoding'=>'a' })
    response
  end

  # Returns a nokogiri document or an error if fetch response status is not 200
  def self.parse(url)
    p = fetch url
    raise(Empty) if p.http_body.content.size.zero?
    p.status==200 ? Nokogiri::HTML(p.body.encode('utf-8')) : raise(NotFound)
  end

  def self._parse(url)
    p = _fetch url
    raise(Empty) if p.body.size.zero?
    p.status==200 ? Nokogiri::HTML(p.body.encode('utf-8')) : raise(NotFound)
  end
end
