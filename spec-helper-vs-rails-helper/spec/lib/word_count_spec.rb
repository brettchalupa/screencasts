require "spec_helper"
require "word_count"

RSpec.describe WordCount do
  describe ".count" do
    it "returns the number of words in the string" do
      expect(WordCount.count("hi there")).to eql(2)
    end
  end
end
