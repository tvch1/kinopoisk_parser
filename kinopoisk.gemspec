Gem::Specification.new do |gem|
  gem.name          = 'kinopoisk'
  gem.version       = '0.0.1'
  gem.authors       = ['RavWar']
  gem.email         = ['rav_war@mail.ru']
  gem.homepage      = 'https://github.com/RavWar/kinopoisk'
  gem.summary       = %q{TODO: Write a gem summary}
  gem.description   = %q{TODO: Write a gem description}

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep %r{^spec/}
  gem.require_paths = %w(lib)

  gem.add_runtime_dependency 'nokogiri'
  gem.add_runtime_dependency 'httpclient'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'webmock'
end
