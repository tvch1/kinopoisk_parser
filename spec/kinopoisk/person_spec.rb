#coding: UTF-8
require 'spec_helper'

describe Kinopoisk::Person, vcr: { cassette_name: 'person' } do
  let(:person) { Kinopoisk::Person.new 13180 }

  it 'should return right url' do
    person.url.should eq('http://www.kinopoisk.ru/name/13180/')
  end

  it { person.poster.should eq('http://st.kinopoisk.ru/images/actor/13180.jpg') }
  it { person.name_en.should eq('Dexter Fletcher') }
  it { person.name.should eq('Декстер Флетчер') }
end
