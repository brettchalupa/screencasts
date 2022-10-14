require "spec_helper"
require "update"

RSpec.describe Update do
  describe ".call" do
    it "returns a string of JSON" do
      res = Update.call
      expect(res).to be_a(String)
      expect(json_as_hash(res)).to be
    end

    it "returns JSON with a message" do
      res = Update.call
      expect(json_as_hash(res)[:message]).to eql("updated")
    end

    it "can call party_time" do
      expect(party_time?).to be(true)
    end
  end
end
