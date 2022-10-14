require "spec_helper"

RSpec.describe Recipe do
  subject { Recipe.new(id: 8) }

  it "has an id" do
    expect(subject.id).to eql(8)
  end

  it_behaves_like "an object with a url"
end
