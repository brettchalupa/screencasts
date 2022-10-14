require "urlable"

class Ingredient
  include Urlable

  attr_reader :id, :recipe

  def initialize(params)
    @id = params.fetch(:id)
    @recipe = params[:recipe]
  end
end
