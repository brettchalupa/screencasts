require "spec_helper"
require "rack/test"

def app
  Rack::Builder.parse_file("config.ru").first
end

def response
  last_response
end

RSpec.configure do |c|
  c.include Rack::Test::Methods
end

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
end
