module Calendly
  class Request
    TOKEN = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2F1dGguY2FsZW5kbHkuY29tIiwiaWF0IjoxNjU1MjE1NzY4LCJqdGkiOiI5ZDczYTU4MS1lOWZhLTQ1MDUtODdkMC1lNzBjZWQ5ODNjMWUiLCJ1c2VyX3V1aWQiOiJjNTJlOTBjZS02MTkyLTQ3MDYtOGIxOS04NTBlZDNlNjMxZTQifQ.nZO6Y47Vl1i3BNpP6jMWecitkaxeFYkMdvj5ym1Xhrk'
    BASE_URL = 'http://api.calendly.com'
    UUID = 'c52e90ce-6192-4706-8b19-850ed3e631e4'
    ORGANIZATION = 'https://api.calendly.com/organizations/2a7498fb-bf14-40b4-971a-16dd78de8285'
     'https://api.calendly.com/organizations/2a7498fb-bf14-40b4-971a-16dd78de8285'

    def self.call(http_method, endpoint)
      result = RestClient::Request.execute(
        method: http_method,
        url: "#{BASE_URL}#{endpoint}?organization=#{ORGANIZATION}",
        headers: { 'Authorization' => TOKEN.to_s,
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
