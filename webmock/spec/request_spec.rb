require "request_helper"

RSpec.describe "API requests" do
  describe "GET /" do
    it "returns the Studio Ghibli films with their director and release year in alphabetical order" do
      film_response = File.open("spec/fixtures/ghibli-films.json")

      stub_request(:get, "https://ghibliapi.herokuapp.com/films")
        .to_return(status: 200, body: film_response)

      get "/"

      expect(response.status.to_i).to eql(200)
      expect(response.body).to include(
        <<-STRING
Arrietty, Hiromasa Yonebayashi, 2010
Castle in the Sky, Hayao Miyazaki, 1986
From Up on Poppy Hill, Gorō Miyazaki, 2011
Grave of the Fireflies, Isao Takahata, 1988
Howl's Moving Castle, Hayao Miyazaki, 2004
Kiki's Delivery Service, Hayao Miyazaki, 1989
        STRING
      )
    end

    it "responds with 'uh-oh' 500 when the API is down" do
      stub_request(:get, "https://ghibliapi.herokuapp.com/films")
        .to_return(status: 500, body: "Something isn't quite right")

      get "/"

      expect(response.status.to_i).to eql(500)
      expect(response.body).to include("uh-oh")
    end
  end
end
