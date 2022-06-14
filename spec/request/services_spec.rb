require 'rails_helper'

RSpec.describe "ServicesController", type: :request do

  context "admin service capabilities" do
    Service.create!([{
      name: 'tooth extraction',
      price: 500,
      branch: 'all'
    },
    {
      name: 'root canal operation',
      price: 2000,
      branch: 'all'
    },
    {
      name: 'basic cleaning',
      price: 800,
      branch: 'all'
    }])

    it 'returns all currently offered services' do
      admin = User.create!(
        email: 'admin@gmail.com',
        password: 'password',
        role: 'admin'
      )

      get "/services"
      json = JSON.parse(response.body)

      expect(json[0].count).to eq(3)
    end

    it 'should allow admin to add a service' do
      admin = User.create!(
        email: 'admin@gmail.com',
        password: 'password',
        role: 'admin'
      )

      post "/services/add", params: {name: 'x-ray', price: 4500, branch: 'main' }
      json = JSON.parse(response.body)

      expect(json["status"]).to eq(201)
      expect(json["message"]).to eq('Service added!')
    end

    it 'should allow admin to remove a service' do
      admin = User.create!(
        email: 'admin@gmail.com',
        password: 'password',
        role: 'admin'
      )

      post "/services/remove", params: {name: 'basic cleaning'}
      json = JSON.parse(response.body)
      
      expect(json["status"]).to eq(201)
      expect(json["message"]).to eq('Service removed!')
    end
  end
end