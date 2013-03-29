#coding: UTF-8
require 'spec_helper'

describe Kinopoisk::Movie, vcr: { cassette_name: 'dexter' } do
  let(:movie) { Kinopoisk::Movie.new 277537 }

  it 'should have same url when initialized by title' do
    VCR.use_cassette('dexter_by_title') do
      duplicate = Kinopoisk::Movie.find_by_title 'Dexter'
      movie.url.should eq(duplicate.url)
    end
  end

  it { movie.url.should eq('http://www.kinopoisk.ru/film/277537/') }
  it { movie.title_ru.should eq('Правосудие Декстера') }
  it { movie.title_en.should eq('Dexter') }
  it { movie.country.should eq('США') }
  it { movie.year.should eq(2006) }
end
