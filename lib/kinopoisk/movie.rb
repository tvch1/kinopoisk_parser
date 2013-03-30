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

    def year
      document.search("table.info a[href*='/m_act%5Byear%5D/']").text.to_i
    end

    def country
      document.search("table.info a[href*='/m_act%5Bcountry%5D/']").text
    end

    def title
      document.search('.moviename-big').xpath('text()').text.strip
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

    def directors
      to_array search_by_itemprop 'director'
    end

    def producers
      to_array search_by_itemprop 'producer'
    end

    def composers
      to_array search_by_itemprop 'musicBy'
    end

    def genres
      to_array search_by_itemprop 'genre'
    end

    def title_en
      search_by_itemprop 'alternativeHeadline'
    end

    def description
      search_by_itemprop 'description'
    end

    def writers
      search_by_text 'сценарий'
    end

    def operators
      search_by_text 'оператор'
    end

    def art_directors
      search_by_text 'художник'
    end

    def editors
      search_by_text 'монтаж'
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

    def search_by_itemprop name
      document.search("[itemprop=#{name}]").text
    end

    def search_by_text name
      to_array document.search("//td[text()='#{name}']").first.next.text
    end

    def to_array string
      string.gsub('...', '').split(', ')
    end
  end
end
