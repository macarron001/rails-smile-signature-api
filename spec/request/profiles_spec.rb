require 'rails_helper'

RSpec.describe "ProfilesController", type: :request do
  context "show a user's profile" do
    it 'should return user details' do
      user = User.create!(
        email: 'dentist@gmail.com',
        password: 'password',
        role: 'dentist'
      )
      
      user.create_profile(
        user_id: user.id,
        first_name: 'Boopy',
        last_name: 'Bork',
        date_of_birth: Date.parse('12/02/1985'),
        sex: 'male',
        mobile: '09193632424',
        address: 'Las Pinas'
      )

      get '/profile', params: {id: user.id }
      json = JSON.parse(response.body)

      expect(json["id"]).to eq(user.id)
      expect(json["email"]).to eq(user.email)
    end
  end
end