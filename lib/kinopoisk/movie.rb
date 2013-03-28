module Kinopoisk
  class Movie
    attr_accessor :id, :url

    def initialize id
      @id  = id
      @url = "http://www.kinopoisk.ru/film/#{id}/"
    end

    def title_ru
      document.css('.moviename-big').xpath('text()').text.strip
    end

    def title_en
      document.search('span[itemprop="alternativeHeadline"]').text
    end

    private

    def document
      @document ||= Nokogiri::HTML Kinopoisk.fetch(url).body
    end
  end
end
