module Kinopoisk
  class Person
    attr_accessor :id, :url, :name

    def initialize id, name=nil
      @id   = id
      @url  = "http://www.kinopoisk.ru/name/#{id}/"
      @name = name
    end
  end
end
