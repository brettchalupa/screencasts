require 'spec_helper'
require 'post'

RSpec.describe Post do
  subject do
    described_class.new(
      title: "10 Tips for Running",
      content: "Lots of great running tips",
      blog: instance_double("Blog", subdomain: "brettcodes")
    )
  end

  describe "#initialize" do
    it "sets the slug to the parameterized title" do
      expect(subject.slug).to eql("10-tips-for-running")
    end
  end

  describe "#subdomain" do
    it "returns the blog's subdomain" do
      expect(subject.subdomain).to eql("brettcodes")
    end
  end
end
