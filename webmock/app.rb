require "sinatra"
require_relative "lib/ghibli"

set :dump_errors, false
set :raise_errors, true
set :show_exceptions, false

get "/" do
  if films = Ghibli.films
    status 200
    films.join("\n")
  else
    status 500
    "uh-oh"
  end
end
