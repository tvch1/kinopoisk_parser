require 'webmock/rspec'
require 'kinopoisk'
require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.cassette_library_dir = 'spec/fixtures'
end
