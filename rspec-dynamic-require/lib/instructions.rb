class Instructions
  attr_reader :text

  def initialize(text:, recipe:)
    @text = text
    @recipe = recipe
  end
end
