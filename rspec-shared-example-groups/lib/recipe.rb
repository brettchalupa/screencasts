require "urlable"

class Recipe
  include Urlable

  attr_reader :id

  def initialize(params)
    @id = params.fetch(:id)
  end
end
