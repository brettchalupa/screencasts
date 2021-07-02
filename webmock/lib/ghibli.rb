require "net/http"
require "json"

class Ghibli
  def self.films
    response = Net::HTTP.get_response(URI("https://ghibliapi.herokuapp.com/films"))

    if response.code.to_i == 200
      films = JSON.parse(response.body)
      films
        .map { |f| "#{f['title']}, #{f['director']}, #{f['release_date']}" }
        .sort
    else
      false
    end
  end
end
