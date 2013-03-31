#coding: UTF-8
module Kinopoisk
  class Person
    attr_accessor :id, :url, :name

    def initialize id, name=nil
      @id   = id
      @url  = "http://www.kinopoisk.ru/name/#{id}/"
      @name = name
    end

    def poster
      doc.search('img.people_thumbnail').first.attr 'src'
    end

    def name
      @name ||= doc.search('.moviename-big').text
    end

    def name_en
      doc.search("//tr[./td/h1[@class='moviename-big']]/following-sibling::tr//span").text
    end

    def partner
      doc.search("//td[@class='type'][contains(text(),'супруг')]").first.next.text
    end

    def birthdate
      Date.strptime doc.search("td.birth").first.attr 'birthdate'
    end

    def birthplace
      search_by_text('место рождения').split(', ').first
    end

    def genres
      search_by_text('жанры').split(', ')
    end

    def career
      search_by_text('карьера').split(', ')
    end

    def total_movies
      search_by_text('всего фильмов').to_i
    end

    def best_movies
      doc.search('td.actor_list a').map(&:text)
    end

    def first_movie
      search_by_text 'первый фильм'
    end

    def last_movie
      search_by_text 'последний фильм'
    end

    def height
      search_by_text 'рост'
    end

    private

    def doc
      @doc ||= Kinopoisk.parse url
    end

    def search_by_text name
      doc.search("//td[@class='type'][text()='#{name}']").first.next.text
    end
  end
end
