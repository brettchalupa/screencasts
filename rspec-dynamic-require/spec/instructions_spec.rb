require "spec_helper"

RSpec.describe Instructions do
  include_context "with recipe"

  subject { Instructions.new(text: "Do this", recipe: recipe) }

  it "has text" do
    expect(subject.text).to eql("Do this")
  end
end
