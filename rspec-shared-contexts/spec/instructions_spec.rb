require "spec_helper"
require_relative "shared_contexts/with_recipe"
require "instructions"
require "recipe"

RSpec.describe Instructions do
  include_context "with recipe"

  subject { Instructions.new(text: "Do this", recipe: recipe) }

  it "has text" do
    expect(subject.text).to eql("Do this")
  end
end
