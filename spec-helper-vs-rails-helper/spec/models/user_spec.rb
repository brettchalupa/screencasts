require 'rails_helper'

RSpec.describe User do
  describe "#commit_author" do
    it "properly formats the author" do
      user = User.new
      user.name = "Brett"
      user.email = "brett@example.com"
      expect(user.commit_author).to eql("Brett <brett@example.com>")
    end
  end
end
