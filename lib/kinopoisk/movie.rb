module Kinopoisk
  class Movie
    attr_accessor :id, :url

    def initialize input
      @id  = input.is_a?(String) ? find_by_title(input) : input
      @url = "http://www.kinopoisk.ru/film/#{id}/"
    end

    def title
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

    def directors
      document.search('td[itemprop="director"]').text.gsub('...','').split(', ')
    end

    private

    def document page=nil
      page ||= Kinopoisk.fetch url unless @doc
      @doc ||= Nokogiri::HTML page.read.encode('utf-8')
    end

    # Kinopoisk has defined first=yes param to redirect to first result
    # Remember response with document method so no additional request
    def find_by_title title
      url  = SEARCH_URL+"#{title}&first=yes"
      page = Kinopoisk.fetch url

      document page
      page.base_uri.to_s.match(/\/(\d*)\/$/)[1]
    end
  end
end
