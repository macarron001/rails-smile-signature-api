require 'rails_helper'

RSpec.describe User, type: :model do

  subject {
    described_class.new(
      email: 'bork@gmail.com',
      password: 'password',
      role: 'staff'
    )
  }

  before(:each) do
    @user = User.create!(
      email: 'boop@test.com', 
      password: 'password',
      role: 'staff'
      )

    @services = ["service1", "service2"]

    @dentist = User.create!(
      email: 'dentist@gmail.com',
      password: 'password',
      role: 'dentist'
    )

    @appointment_params = {
      branch: 'marcos-alvarez',
      schedule_date: Date.parse('29/06/2022'),
      schedule_time: Time.parse('13:00'),
      first_name: 'Bork',
      last_name: 'Borky',
      mobile: '0915549323',
      services: @services
    }

    @profile_params = {
      user_id: @user.id,
      first_name: 'Boopy',
      last_name: 'Bork',
      date_of_birth: Date.parse('12/02/1985'),
      sex: 'male',
      mobile: '09193632424',
      address: 'Las Pinas'
    }

    @record_params = {
      first_name: 'Bork',
      last_name: 'Borky',
      branch: 'marcos-alvarez',
      tooth: [15, 16, 17],
      services: @services,
      remarks: 'some remarks'
    }

  end


  context 'validating user creation' do
    it 'should create a valid user' do
      expect(subject).to be_valid
    end

    it 'is not valid without email' do
      subject.email = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without password' do
      subject.password = nil

      expect(subject).not_to be_valid
    end

  end

  context 'validating user associations' do
    it "has many appointments" do
      should respond_to(:appointments)
    end
    it "has many transactions" do
      should respond_to(:transactions)
    end

    it "has many records" do
      should respond_to(:patient_records)
    end

    it "has a profile" do
      should respond_to(:profile)
    end

  context 'validating user capabilities'
    it 'can set an appointment' do
      @dentist.set_appointment(@appointment_params, @dentist.id)
      appointment = @dentist.appointments

      expect(appointment).not_to be_nil
    end

    it 'can create a profile' do
      @user.create_profile(@profile_params)
      profile = Profile.find_by(user_id: @user.id)

      expect(profile).not_to be_nil
    end

    it 'can generate a record' do
      @dentist.create_record(@record_params)
      record = @dentist.patient_records

      expect(record).not_to be_nil
    end
  end
end