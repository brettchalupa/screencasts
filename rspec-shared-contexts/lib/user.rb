require "urlable"

class User
  include Urlable

  attr_reader :id

  def initialize(params)
    @id = params.fetch(:id)
  end
end
