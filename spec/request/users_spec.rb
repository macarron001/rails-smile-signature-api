require 'rails_helper'

RSpec.describe "CurrentUsersController", type: :request do
  describe 'check if dentist is available' do
    it 'should tell if dentist schedule is open' do
      dentist = User.create!(email: 'dentist@staff.com', password: 'password', role: 'dentist')

      get "/appointments"
      json = JSON.parse(response.body)

      expect(json[0]["available?"]).to eq(true)
    end
  end

  describe 'dentist capabilities' do
    it 'should be able to set an appointment' do
      dentist = User.create!(email: 'dentist@staff.com', password: 'password', role: 'dentist')
      dentist.set_appointment({
      branch: 'marcos-alvarez',
      schedule_date: Date.parse('29/06/2022'),
      schedule_time: Time.parse('13:00'),
      first_name: 'Bork',
      last_name: 'Borky',
      mobile: '0915549323',
      services: ['tooth-extraction']
      }, dentist.id)

      post '/dentist/appointment', params: {appointment_params: {
        branch: 'marcos-alvarez',
        schedule_date: Date.parse('29/06/2022'),
        schedule_time: Time.parse('13:00'),
        first_name: 'Bork',
        last_name: 'Borky',
        mobile: '0915549323',
        services: ['tooth-extraction']
      }}

      json = JSON.parse(response.body)

      expect(json["status"]).to eq(201)
        expect(json["message"]).to eq('Appointment set!')
    end
  end

    it 'should be able to create a patient record' do
      dentist = User.create!(email: 'dentist@staff.com', password: 'password', role: 'dentist')
      
      post '/dentist/record', params: {record_params: {
        first_name: 'Bork',
        last_name: 'Borky',
        branch: 'marcos-alvarez',
        tooth: [15, 16, 17],
        services: ['tooth-extraction'],
        remarks: 'some remarks'
        }}

        json = JSON.parse(response.body)
        expect(json["status"]).to eq(201)
        expect(json["message"]).to eq('Record created!')
    end
end