require "spec_helper"

class NoBlockGivenError < StandardError; end

class BookClient
  class << self
    def reset
      @config = nil
    end

    def config
      @config ||= Struct.new(:api_key, :verbose_logging, :sandbox).new
    end

    def configure
      if block_given?
        yield(config)
      else
        raise NoBlockGivenError, "You must give a block to configure"
      end
    end

    def configured?
      config && !config.api_key.nil?
    end

    def search(query)
      if configured?
        puts query
      else
        throw "please configure the client"
      end
    end
  end
end

RSpec.describe BookClient do
  before do
    BookClient.reset
  end

  describe ".configure" do
    it "yields a block that allows values to be set" do
      BookClient.configure do |config|
        config.api_key = "ABC123"
        config.verbose_logging = true
        config.sandbox = true
      end

      expect(BookClient.config.api_key).to eql("ABC123")
      expect(BookClient.config.verbose_logging).to be(true)
      expect(BookClient.config.sandbox).to be(true)
    end

    it "raises an exception when no block is given" do
      expect { BookClient.configure }.to raise_exception(NoBlockGivenError)
    end
  end

  describe ".configured?" do
    it "returns true when the client has been configured" do
      BookClient.configure do |config|
        config.api_key = "ABC123"
      end

      expect(BookClient).to be_configured
    end

    it "returns false when the client has not yet been configured" do
      expect(BookClient).to_not be_configured
    end
  end
end

class Books
  def self.search(query)
    BookClient.configure do |config|
      config.api_key = "ABC123"
    end

    BookClient.search(query)
  end
end

Books.search("Murakami")
