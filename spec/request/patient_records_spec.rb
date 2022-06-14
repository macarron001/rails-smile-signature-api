require 'rails_helper'

RSpec.describe "PatientRecordsController", type: :request do
  context "Get Patient Records List" do
    it "returns a list of all patient records" do
      dentist = User.create!(
        email: 'dentist@gmail.com',
        password: 'password',
        role: 'dentist'
      )

      dentist.create_record(
        first_name: 'Bork',
        last_name: 'Borky',
        branch: 'marcos-alvarez',
        tooth: [15, 16, 17],
        services: ['basic-cleaning'],
        remarks: 'some remarks'
      )

      dentist.create_record(
        first_name: 'Boop',
        last_name: 'Boopy',
        branch: 'marcos-alvarez',
        tooth: [17],
        services: ['tooth-extraction'],
        remarks: 'some remarks'
      )

      get '/records'
      json = JSON.parse(response.body)

      expect(json.count).to eq(2)
    end

    it "returns a list of records under a specific dentist" do
      dentist = User.create!(
        email: 'dentist@gmail.com',
        password: 'password',
        role: 'dentist'
      )

      dentist.create_record(
        first_name: 'Bork',
        last_name: 'Borky',
        branch: 'marcos-alvarez',
        tooth: [15, 16, 17],
        services: ['basic-cleaning'],
        remarks: 'some remarks'
      )

      get '/records/dentist', params: {id: dentist.id }
      json = JSON.parse(response.body)

      expect(json[0]['user_id']).to eq(dentist.id)
    end

    it "returns a list of records under a specific patient" do
      dentist = User.create!(
        email: 'dentist@gmail.com',
        password: 'password',
        role: 'dentist'
      )

      dentist.create_record(
        first_name: 'Bork',
        last_name: 'Borky',
        branch: 'marcos-alvarez',
        tooth: [15, 16, 17],
        services: ['basic-cleaning'],
        remarks: 'some remarks'
      )

      get '/records/patient', params: {
        first_name: 'Bork', 
        last_name: 'Borky'
      }
      json = JSON.parse(response.body)

      expect(json[0]['first_name']).to eq('Bork')
      expect(json[0]['last_name']).to eq('Borky')
    end
  end
end