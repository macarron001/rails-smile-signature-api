require 'rails_helper'

RSpec.describe "CurrentUsersController", type: :request do

  Transaction.create!([{
    first_name: 'Bork1',
    last_name: 'Bork',
    services: ['tooth-extraction'],
    status: 'partial',
    branch: 'main',
    amount: 500,
    remaining: 0,
    payment_type: 'cash'
  },
  {
    first_name: 'Bork2',
    last_name: 'Bork',
    services: ['tooth-extraction'],
    status: 'follow-up',
    branch: 'main',
    amount: 600,
    remaining: 0,
    payment_type: 'cash'
  },
  {
    first_name: 'Bork3',
    last_name: 'Bork',
    services: ['tooth-extraction'],
    status: 'full',
    branch: 'main',
    amount: 700,
    remaining: 0,
    payment_type: 'cash'
  }])

  describe "Get all transactions" do

    it "returns all recorded transactions" do
      dentist = User.create!(email: 'dentist@staff.com', password: 'password', role: 'dentist')
      
      get "/transactions/all"
      json = JSON.parse(response.body)

      expect(json[0].count).to eq(3)
    end

    it "returns all 'partial' transactions" do
      dentist = User.create!(email: 'dentist@staff.com', password: 'password', role: 'dentist')
      
      get "/transactions/partial"
      json = JSON.parse(response.body)

      expect(json[0].count).to eq(1)
    end

    it "returns all 'full' transactions" do
      dentist = User.create!(email: 'dentist@staff.com', password: 'password', role: 'dentist')
      
      get "/transactions/full"
      json = JSON.parse(response.body)

      expect(json[0].count).to eq(1)
    end
    
    it "returns all 'follow-up' transactions" do
      dentist = User.create!(email: 'dentist@staff.com', password: 'password', role: 'dentist')
      
      get "/transactions/follow-up"
      json = JSON.parse(response.body)

      expect(json[0].count).to eq(1)
    end
  end
end