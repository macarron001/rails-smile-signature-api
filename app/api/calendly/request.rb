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
      {code: result.code, status:'Success', data: JSON.parse(result.body)}
    rescue RestClient::ExceptionWithResponse => error
      {code: error.http_code, status: error.message, data: Errors.map(error.http_code)}
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
