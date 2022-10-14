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
      expect(json_as_hash(res))
        .to have_key_with_value(:message, "updated")

      expect(json_as_hash(res))
        .to_not have_key_with_value(:foo, "updated")
    end

    it "can call party_time" do
      expect(party_time?).to be(true)
    end

    it "supports contain" do
      expect([1, 2]).to contain_some_or_all(1)
      expect([1, 2]).to contain_some_or_all(1, 2)
      expect([1, 2]).to_not contain_some_or_all(3)
      expect([1, 2]).to contain_some_or_all(1, 2, 3)
    end
  end
end
