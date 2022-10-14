module JSONHelper
  def json_as_hash(json_str)
    require "json"
    JSON.parse(json_str, { symbolize_names: true })
  end
end
