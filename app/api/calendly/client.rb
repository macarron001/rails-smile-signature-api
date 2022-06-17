module Calendly
  class Client
    ORGANIZATION = 'https://api.calendly.com/organizations/2a7498fb-bf14-40b4-971a-16dd78de8285'

    def self.show_me
      response = Request.call('get', '/users/me')
    end

    def self.show_events
      response = Request.call('get', "/scheduled_events?organization=#{ORGANIZATION}")
    end

    def self.show_specific_event(id)
      response = Request.call('get', "/scheduled_events?organization=#{ORGANIZATION}&id=#{id}")
    end

    def self.show_specific_guest_invitees(event_id)
      response = Request.call('get', "/scheduled_events/#{event_id}/invitees/")
    end

    def self.show_specific_guest(event_id, guest_id)
      response = Request.call('get', "/scheduled_events/#{event_id}/invitees/#{guest_id}")
    end

    def self.cancel_specific_event(event_id)
      response = Request.call('get', "/scheduled_events/#{event_id}/cancellation")
    end

    def self.create_single_use_scheduling_link
      response = Request.call('post', '/scheduling_links')
    end

    # def self.show_events
    #   response = Request.call('get', "/scheduled_events?organization=#{ORGANIZATION}")
    # end
  end
end
