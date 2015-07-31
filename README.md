# Важно

Чтобы кинопоиск нас не банил мы работам через прокси на хероку.
Когда деплоишь на зероку новый проект он дает новый IP. 
Соответсвенно как только забанили один из наших проскей надо создать новый. С тем же именем с которым забанили.

идет запросы вида
``` ruby
http://kinopoisk-parser-#{server_id}.herokuapp.com/page?url=#{url
```
где сервер_id от 0 до 5



# Kinopoisk Parser

Easily search and access information on kinopoisk.ru

[![Build Status](https://secure.travis-ci.org/RavWar/kinopoisk_parser.png)](http://travis-ci.org/RavWar/kinopoisk_parser)
[![Dependency Status](https://gemnasium.com/RavWar/kinopoisk_parser.png)](https://gemnasium.com/RavWar/kinopoisk_parser)
[![Gem Version](https://badge.fury.io/rb/kinopoisk_parser.png)](http://badge.fury.io/rb/kinopoisk_parser)
[![Code Climate](https://codeclimate.com/github/RavWar/kinopoisk_parser.png)](https://codeclimate.com/github/RavWar/kinopoisk_parser)

## Installation

Add this line to your application's Gemfile:

    gem 'kinopoisk_parser'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kinopoisk_parser

## Usage

### Movie

Initialize with

    m = Kinopoisk::Movie.new 277537

or

    m = Kinopoisk::Movie.new 'Dexter'

Access information

    m.title
    #=> "Правосудие Декстера"

    m.countries
    #=> ["США"]

    m.slogan
    #=> "«Takes life. Seriously.»"

### Search

    s = Kinopoisk::Search.new 'Life of Pi'

    s.movies.count
    #=> 6

    s.people.count
    #=> 5

### Person

    p = Kinopoisk::Person.new 25584

    p.name
    #=> "Брэд Питт"

    p.career
    #=> ["Актер", "Продюсер"]

## Documentation

http://rubydoc.info/gems/kinopoisk_parser/frames

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
