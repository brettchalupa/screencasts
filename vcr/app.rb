require "sinatra"
require_relative "lib/ghibli"

set :dump_errors, false
set :raise_errors, true
set :show_exceptions, false

get "/" do
  Ghibli.films.join("\n")
end
