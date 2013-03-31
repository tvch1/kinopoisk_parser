#coding: UTF-8
module Kinopoisk
  class Search
    attr_accessor :query, :url

    def initialize query
      @query = query
      @url   = SEARCH_URL + query.to_s
    end

    def movies
      doc.search(".info .name a[href*='/film/']").map{|n| Movie.new n.attr('href')
        .match(/\/film\/(\d*)\//)[1].to_i, n.text.gsub(' (сериал)', '') }
    end

    def people
      doc.search(".info .name a[href*='/people/']").map{|n| Person.new n.attr('href')
        .match(/\/people\/(\d*)\//)[1].to_i, n.text }
    end

    private

    def doc
      @doc ||= Nokogiri::HTML Kinopoisk.fetch(url).body.encode('utf-8')
    end
  end
end
