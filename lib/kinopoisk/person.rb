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

    private

    def doc
      @doc ||= Kinopoisk.parse url
    end
  end
end
