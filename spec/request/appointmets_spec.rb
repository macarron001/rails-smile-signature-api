require 'rails_helper'

RSpec.describe "AppointmentsController", type: :request do
  describe "Get all patient appointments" do
    
    it "returns all appointments" do
      dentist = User.create!(email: 'dentist@staff.com', password: 'password', role: 'dentist')
      appoitment = Appointment.create!(
        user_id: dentist.id
        branch: 'marcos-alvarez',
        schedule_date: Date.parse('22/06/2022'),
        schedule_time: Time.parse('13:00'),
        first_name: 'Bork',
        last_name: 'Borky',
        mobile: '0915549323',
        services: ['tooth extraction', 'general checkup' ]
      ) 

      get "/appointments"
      json = JSON.parse(response.body)

      expect(json[0]["branch"]).to eq("marcos-alvarez")
      expect(json[0]["first_name"]).to eq("Bork")
    end
  end
end

