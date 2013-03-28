#coding: UTF-8
require 'spec_helper'

describe Kinopoisk::Movie do
  let(:movie) { Kinopoisk::Movie.new 277537 }

  it 'should return the right url' do
    movie.url.should eq('http://www.kinopoisk.ru/film/277537/')
  end

  it 'should return the right title' do
    movie.title_ru.should eq('Правосудие Декстера')
  end

  it 'should return the right title' do
    movie.title_en.should eq('Dexter')
  end
end
