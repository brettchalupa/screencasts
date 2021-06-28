class Router
  def initialize(domain:, protocol: "https")
    @domain = domain
    @protocol = protocol
  end

  def url_for(object)
    raise NotRoutableError.new unless object.respond_to?(:subdomain) && object.respond_to?(:slug)

    "#{@protocol}://#{object.subdomain}.#{@domain}/#{object.slug}"
  end

  private

  attr_reader :domain, :protocol

  class NotRoutableError < StandardError; end
end
