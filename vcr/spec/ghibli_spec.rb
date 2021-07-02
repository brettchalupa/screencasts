require "spec_helper"
require "ghibli"

RSpec.describe Ghibli do
  describe ".films" do
    it "returns an array of Ghibli films with some info sorted by title" do
      expect(Net::HTTP).to receive(:get).with(kind_of(URI)) do
        [
          { "title": "Castle in the Sky", "director": "Hayao Miyazaki", "release_date": "1986" },
          { "title": "Arrietty", "director": "Hiromasa Yonebayashi", "release_date": "2010" }
        ].to_json
      end

      expect(Ghibli.films).to eql(
        [
          "Arrietty, Hiromasa Yonebayashi, 2010",
          "Castle in the Sky, Hayao Miyazaki, 1986",
        ]
      )
    end
  end
end
