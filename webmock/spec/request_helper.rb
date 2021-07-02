require "spec_helper"
require "rack/test"
require "webmock/rspec"

def app
  Rack::Builder.parse_file("config.ru").first
end

def response
  last_response
end

RSpec.configure do |c|
  c.include Rack::Test::Methods
end
