RSpec.shared_examples "an object with a url" do
  describe "#to_url" do
    it "returns the class name and the id as the path" do
      expect(subject.to_url)
        .to eql("https://example.com/#{subject.url_path_prefix}/#{subject.id}")
    end
  end
end
