module Calendly
  class Request
    def self.call(http_method, endpoint)
      result = RestClient::Request.execute(
        method: http_method,
        url: "#{ENV['BASE_URL']}#{endpoint}",
        headers: { 'Authorization' => ENV['TOKEN'].to_s,
                   'Content-Type' => 'application/json' }
      )
      JSON.parse(result.body)
    end

    # def self.call(http_method, endpoint)
    #   result = RestClient::Request.execute(
    #     method: http_method,
    #     url: "#{BASE_URL}#{endpoint}?organization=#{ORGANIZATION}",
    #     headers: { 'Authorization' => TOKEN.to_s,
    #                'Content-Type' => 'application/json' }
    #   )
    #   JSON.parse(result.body)
    # end
  end
end
