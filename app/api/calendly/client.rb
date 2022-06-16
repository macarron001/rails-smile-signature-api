module Calendly
  class Client
    def self.show_me
      response = Request.call('get', '/users/me')
    end

    def self.show_events
      response = Request.call('get', '/scheduled_events')
    end
  end
end
