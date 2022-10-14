require "spec_helper"
require "create"

RSpec.describe Create do
  describe ".call" do
    it "returns a string of JSON" do
      res = Create.call
      expect(res).to be_a(String)
      expect(json_as_hash(res)).to be
    end

    it "returns JSON with a message" do
      res = Create.call
      expect(json_as_hash(res)[:message]).to eql("created")
    end
  end
end
