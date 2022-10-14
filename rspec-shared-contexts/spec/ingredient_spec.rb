require "spec_helper"
require_relative "shared_examples/to_url"
require_relative "shared_contexts/with_recipe"
require "ingredient"
require "recipe"

RSpec.describe Ingredient do
  include_context "with recipe"

  let(:recipe_name) { "Pizza dough" }

  subject { Ingredient.new(id: 1, recipe: recipe) }

  it "has an id" do
    expect(subject.id).to eql(1)
  end

  it "has a recipe with a name" do
    expect(subject.recipe.name).to eql("Pizza dough")
  end

  it_behaves_like "an object with a url"
end
