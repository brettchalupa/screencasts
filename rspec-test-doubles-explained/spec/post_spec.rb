require 'spec_helper'
require 'post'

RSpec.describe Post do
  subject do
    described_class.new(
      title: "10 Tips for Running",
      content: "Lots of great running tips",
      blog: instance_double("Blog")
    )
  end

  describe "#initialize" do
    it "sets the slug to the parameterized title" do
      expect(subject.slug).to eql("10-tips-for-running")
    end
  end
end
