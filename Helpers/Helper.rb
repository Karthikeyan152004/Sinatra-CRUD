require 'json'

module Json_body_parser
  REQUIRED_FIELDS = %w[name price].freeze
  def json_body
    request.body.rewind
    JSON.parse(request.body.read)

  rescue JSON::ParserError
    halt 400, {error:"Invalid JSON"}.to_json
  end

  def serialize(body)
    missing = REQUIRED_FIELDS.select { |key| !body.has_key?(key)}
    halt 400 , {error: "the required fields are missing",missing:missing}.to_json unless missing.empty?

  end
end