require "net/http"
require "json"

class Ghibli
  def self.films
    response = Net::HTTP.get(URI("https://ghibliapi.herokuapp.com/films"))
    films = JSON.parse(response)
    films
      .map { |f| "#{f['title']}, #{f['director']}, #{f['release_date']}" }
      .sort
  end
end
