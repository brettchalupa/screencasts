module Urlable
  def to_url
    "https://example.com/#{url_path_prefix}/#{id}"
  end

  def url_path_prefix
    self.class.to_s.downcase
  end
end
