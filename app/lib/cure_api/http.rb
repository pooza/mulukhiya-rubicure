require 'httparty'

module CureAPI
  class HTTP
    def get(url)
      response = HTTParty.get(url)
      raise "Bad response #{response.code}" unless response.code < 400
      return response.parsed_response
    end
  end
end
