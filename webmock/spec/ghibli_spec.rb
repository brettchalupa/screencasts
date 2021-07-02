require "spec_helper"
require "ghibli"

RSpec.describe Ghibli do
  describe ".films" do
    it "returns an array of Ghibli films with some info sorted by title" do
      expect(Net::HTTP).to receive(:get_response).with(kind_of(URI)) do
        instance_double("Net::HTTPOK", code: "200", body: [
          { "title": "Castle in the Sky", "director": "Hayao Miyazaki", "release_date": "1986" },
          { "title": "Arrietty", "director": "Hiromasa Yonebayashi", "release_date": "2010" }
        ].to_json)
      end

      expect(Ghibli.films).to eql(
        [
          "Arrietty, Hiromasa Yonebayashi, 2010",
          "Castle in the Sky, Hayao Miyazaki, 1986",
        ]
      )
    end

    it "returns false when the API request is not a 200" do
      expect(Net::HTTP).to receive(:get_response).with(kind_of(URI)) do
        instance_double("Net::HTTPInternalServerError", code: "500", body: "Something's not right")
      end

      expect(Ghibli.films).to be(false)
    end
  end
end
