require "request_helper"

RSpec.describe "API requests" do
  describe "GET /" do
    it "returns the Studio Ghibli films with their director and release year in alphabetical order" do
      VCR.use_cassette("ghibli-films") do
        get "/"
      end

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
  end
end
