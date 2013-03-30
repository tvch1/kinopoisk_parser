#coding: UTF-8
require 'spec_helper'

describe Kinopoisk::Movie, vcr: { cassette_name: 'dexter' } do
  let(:movie) { Kinopoisk::Movie.new 277537 }

  it { movie.url.should eq('http://www.kinopoisk.ru/film/277537/') }
  it { movie.directors.should eq(['Джон Дал','Стив Шилл','Кит Гордон']) }
  it { movie.title.should eq('Правосудие Декстера') }
  it { movie.title_en.should eq('Dexter') }
  it { movie.country.should eq('США') }
  it { movie.year.should eq(2006) }

  it 'should make only one request' do
    movie.title
    movie.country
    a_request(:get, movie.url).should have_been_made.once
  end

  context 'by title', vcr: { cassette_name: 'dexter_by_title' } do
    let(:movie_by_title) { Kinopoisk::Movie.new 'Dexter' }

    it { movie.url.should eq(movie_by_title.url) }

    it 'should make only one request' do
      movie_by_title.title

      url = Kinopoisk::SEARCH_URL+'Dexter&first=yes'
      a_request(:get, url).should have_been_made.once
    end
  end
end
