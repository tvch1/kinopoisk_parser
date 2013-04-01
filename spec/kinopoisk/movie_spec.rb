#coding: UTF-8
require 'spec_helper'

describe Kinopoisk::Movie, vcr: { cassette_name: 'movie' } do
  let(:movie) { Kinopoisk::Movie.new 277537 }

  it { movie.url.should eq('http://www.kinopoisk.ru/film/277537/') }
  it { movie.title.should eq('Правосудие Декстера') }
  it { movie.title_en.should eq('Dexter') }
  it { movie.countries.should eq(['США']) }
  it { movie.year.should eq(2006) }
  it { movie.poster.should eq('http://st.kinopoisk.ru/images/film/277537.jpg') }
  it { movie.poster_big.should eq('http://st.kinopoisk.ru/images/film_big/277537.jpg') }
  it { movie.producers.should eq(['Сара Коллетон','Джон Голдвин','Роберт Ллойд Льюис']) }
  it { movie.art_directors.should eq(['Джессика Кендер','Энтони Коули','Эрик Уейлер']) }
  it { movie.operators.should eq(['Ромео Тироне','Джеф Джёр','Мартин Дж. Лэйтон']) }
  it { movie.editors.should eq(['Луис Ф. Циоффи','Стюарт Шилл','Мэттью Колонна']) }
  it { movie.writers.should eq(['Джефф Линдсэй','Джеймс Манос мл.','Скотт Бак']) }
  it { movie.actors.should include('Майкл С. Холл', 'Дженнифер Карпентер') }
  it { movie.genres.should eq(['триллер','драма','криминал', 'детектив']) }
  it { movie.directors.should eq(['Джон Дал','Стив Шилл','Кит Гордон']) }
  it { movie.slogan.should eq('«Takes life. Seriously.»') }
  it { movie.description.should match('Декстер Морган.') }
  it { movie.world_premiere.should eq('1 октября 2006') }
  it { movie.ru_premiere.should eq('3 ноября 2008') }
  it { movie.composers.should eq(['Дэниэл Лихт']) }
  it { movie.imdb_rating_count.should be_a(Integer) }
  it { movie.imdb_rating.should be_a(Float) }
  it { movie.rating_count.should be_a(Integer) }
  it { movie.rating.should be_a(Float) }
  it { movie.length.should eq('55 мин.') }

  it 'should make only one request' do
    movie.title
    movie.countries
    a_request(:get, movie.url).should have_been_made.once
  end

  it 'should raise error if nothing found' do
    expect { Kinopoisk::Movie.new(111111111).title }.to raise_error
  end

  context 'by title' do
    let(:movie_by_title) { Kinopoisk::Movie.new 'Dexter' }

    it { movie.url.should eq(movie_by_title.url) }

    it 'should make only one request to initialize' do
      movie_by_title
      a_request(:get, /.*/).should have_been_made.once
    end

    it 'should make max two requests' do
      movie_by_title.title
      movie_by_title.countries
      a_request(:get, /.*/).should have_been_made.twice
    end
  end
end
