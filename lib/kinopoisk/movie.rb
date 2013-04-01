#coding: UTF-8
module Kinopoisk
  class Movie
    attr_accessor :id, :url, :title

    # New object can be initialized with id(integer) or title(string).
    #
    #   Kinopoisk::Movie.new 277537
    #   Kinopoisk::Movie.new 'Dexter'
    #
    # Initializing by title would send a search request and return first match.
    # Movie page request is made once and on the first access to a remote data.
    #
    def initialize(input, title=nil)
      @id    = input.is_a?(String) ? find_by_title(input) : input
      @url   = "http://www.kinopoisk.ru/film/#{id}/"
      @title = title
    end

    def actors
      doc.search('td.actor_list div a').map{|n| n.text.gsub("\n",'').strip}
        .delete_if{|text| text=='...'}
    end

    def title
      @title ||= doc.search('.moviename-big').xpath('text()').text.strip
    end

    def imdb_rating_count
      doc.search('div.block_2 div:last').text.gsub(/[ ()]/, '').to_i
    end

    def imdb_rating
      doc.search('div.block_2 div:last').text[/\d.\d\d/].to_f
    end

    def year
      doc.search("table.info a[href*='/m_act%5Byear%5D/']").text.to_i
    end

    def countries
      doc.search("table.info a[href*='/m_act%5Bcountry%5D/']").map(&:text)
    end

    def budget
      doc.search("//td[text()='бюджет']/following-sibling::*//a").text
    end

    def gross_ru
      doc.search("td#div_rus_box_td2 a").text
    end

    def gross_us
      doc.search("td#div_usa_box_td2 a").text
    end

    def gross_world
      doc.search("td#div_world_box_td2 a").text
    end

    def poster
      doc.search("img[itemprop='image']").first.attr 'src'
    end

    def premiere_world
      doc.search('td#div_world_prem_td2 a:first').text
    end

    def premiere_ru
      doc.search('td#div_rus_prem_td2 a:first').text
    end

    def rating
      doc.search('span.rating_ball').text.to_f
    end

    def poster_big
      poster.gsub 'film', 'film_big'
    end

    def length
      doc.search('td#runtime').text.to_i
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

    def rating_count
      search_by_itemprop('ratingCount').to_i
    end

    def writers
      to_array search_by_text 'сценарий'
    end

    def operators
      to_array search_by_text 'оператор'
    end

    def art_directors
      to_array search_by_text 'художник'
    end

    def editors
      to_array search_by_text 'монтаж'
    end

    def slogan
      search_by_text 'слоган'
    end

    private

    def doc
      @doc ||= Kinopoisk.parse url
    end

    # Kinopoisk has defined first=yes param to redirect to first result
    # Return its id from location header
    def find_by_title(title)
      url = SEARCH_URL+"#{title}&first=yes"
      Kinopoisk.fetch(url).headers['Location'].to_s.match(/\/(\d*)\/$/)[1]
    end

    def search_by_itemprop(name)
      doc.search("[itemprop=#{name}]").text
    end

    def search_by_text(name)
      doc.search("//td[text()='#{name}']/following-sibling::*").text
    end

    def to_array(string)
      string.gsub('...', '').split(', ')
    end
  end
end
