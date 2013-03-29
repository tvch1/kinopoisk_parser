module Kinopoisk
  class Movie
    attr_accessor :id, :url
    # alias_method :find_by_id, :initialize

    def initialize id
      @id  = id
      @url = "http://www.kinopoisk.ru/film/#{id}/"
    end

    # Kinopoisk has defined first=yes param to redirect to first result
    def self.find_by_title title
      url = "http://www.kinopoisk.ru/index.php?first=yes&kp_query=#{title}"
      id  = Kinopoisk.fetch(url).base_uri.to_s.match(/\/(\d*)\/$/)[1]
      new id
    end

    def title_ru
      document.css('.moviename-big').xpath('text()').text.strip
    end

    def title_en
      document.search('span[itemprop="alternativeHeadline"]').text
    end

    def year
      document.search("table.info a[href*='/m_act%5Byear%5D/']").text.to_i
    end

    def country
      document.search("table.info a[href*='/m_act%5Bcountry%5D/']").text
    end

    private

    def document
      @document ||= Nokogiri::HTML Kinopoisk.fetch(url).read.encode('utf-8')
    end
  end

  # Headers are needed to mimic proper request so kinopoisk won't block it
  def self.fetch url
    open url, 'User-Agent'=>'Mozilla', 'Accept-Encoding'=>'a'
  end
end
