require 'json'

module Requests
  def response_body_as_json
    JSON.parse(response.body).deep_symbolize_keys
  end
end
