require 'spec_helper'

describe Kinopoisk::Search, vcr: { cassette_name: 'search' } do
  let(:search) { Kinopoisk::Search.new 'Dexter' }

  it 'should return right url' do
    search.url.should eq(Kinopoisk::SEARCH_URL+'Dexter')
  end

  it 'should make only one request' do
    search.movies
    search.people
    a_request(:get, search.url).should have_been_made.once
  end

  it 'should return movie objects' do
    search.movies.first.should be_a(Kinopoisk::Movie)
  end

  it 'should return person objects' do
    search.people.first.should be_a(Kinopoisk::Person)
  end
end
