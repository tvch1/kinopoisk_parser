#coding: UTF-8
module Kinopoisk
  class Movie
    attr_accessor :id, :url

    # New object can be initialized with id(integer) or title(string).
    #
    #   Kinopoisk::Movie.new 277537
    #   Kinopoisk::Movie.new 'Dexter'
    #
    # Initializing by title would send a search request and return first match.
    # Movie page request is made once on the first access to a remote data.
    #
    def initialize input
      @id  = input.is_a?(String) ? find_by_title(input) : input
      @url = "http://www.kinopoisk.ru/film/#{id}/"
    end

    def title
      document.search('.moviename-big').xpath('text()').text.strip
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

    def writers
      document.search("//td[text()='сценарий']").first.next.text.gsub('...','').split(', ')
    end

    def producers
      document.search('td[itemprop="producer"]').text.gsub('...','').split(', ')
    end

    def operators
      document.search("//td[text()='оператор']").first.next.text.gsub('...','').split(', ')
    end

    def composers
      document.search('td[itemprop="musicBy"]').text.gsub('...','').split(', ')
    end

    def art_directors
      document.search("//td[text()='художник']").first.next.text.gsub('...','').split(', ')
    end

    def editors
      document.search("//td[text()='монтаж']").first.next.text.gsub('...','').split(', ')
    end

    def genres
      document.search('td[itemprop="genre"]').text.gsub('...','').split(', ')
    end

    def world_premiere
      document.search('td#div_world_prem_td2 a:first').text
    end

    def ru_premiere
      document.search('td#div_rus_prem_td2 a:first').text
    end

    def length
      document.search('td#runtime').text
    end

    def description
      document.search('div[itemprop="description"]').text
    end

    private

    def document
      @doc ||= Nokogiri::HTML Kinopoisk.fetch(url).body.encode('utf-8')
    end

    # Kinopoisk has defined first=yes param to redirect to first result
    # Return its id from location header
    def find_by_title title
      url = SEARCH_URL+"#{title}&first=yes"
      Kinopoisk.fetch(url).headers['Location'].to_s.match(/\/(\d*)\/$/)[1]
    end
  end
end
