require "request_helper"


RSpec.describe "API requests" do
  describe "GET /" do
    it "returns Hello!" do
      get "/"

      expect(response).to be_ok
      expect(response.body).to eql("Hello!")
    end
  end
end
