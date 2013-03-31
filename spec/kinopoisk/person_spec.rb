require 'spec_helper'

describe Kinopoisk::Person, vcr: { cassette_name: 'person' } do
  let(:person) { Kinopoisk::Person.new 13180 }

  it 'should return right url' do
    person.url.should eq('http://www.kinopoisk.ru/name/13180/')
  end
end
