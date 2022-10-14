require "urlable"

class Recipe
  include Urlable

  attr_reader :id, :name

  def initialize(params)
    @id = params.fetch(:id)
    @name = params[:name]
  end
end
