RSpec.shared_context "with recipe" do
  let(:recipe_name) { "Granola" }
  let(:recipe) { Recipe.new(id: 1, name: recipe_name) }
end
