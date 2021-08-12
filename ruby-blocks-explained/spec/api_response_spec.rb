require "spec_helper"
require "json"

class ApiResponse
  def self.build(&block)
    res = new
    res.instance_exec(&block) if block
    JSON.generate(res.body)
  end

  attr_accessor :body

  def initialize
    self.body = {
      success: true,
      version: 1
    }
  end

  def set(key, value)
    self.body[key] = value
  end

  def resolve_object(object)
    objects = self.body[:objects] || []
    objects.push(object.title)
    self.body[:objects] = objects
  end
end

RSpec.describe ApiResponse do
  describe ".build" do
    it "responds with json info about the API" do
      expect(ApiResponse.build).to eql(
        JSON.generate({
          success: true,
          version: 1
        })
      )
    end

    it "supports setting custom response keys and values" do
      response = ApiResponse.build do |res|
        set(:book, "A Wild Sheep Chase")
      end

      expect(response).to eql(
        JSON.generate({
          success: true,
          version: 1,
          book: "A Wild Sheep Chase"
        })
      )
    end

    it "supports resolving book objects" do
      book_1 = double(title: "A Wild Sheep Chase")
      book_2 = double(title: "Kafka on the Shore")

      response = ApiResponse.build do
        resolve_object(book_1)
        resolve_object(book_2)
        set(:object_type, :book)
      end

      expect(response).to eql(
        JSON.generate({
          success: true,
          version: 1,
          objects: [
            "A Wild Sheep Chase",
            "Kafka on the Shore"
          ],
          object_type: "book"
        })
      )
    end
  end
end
