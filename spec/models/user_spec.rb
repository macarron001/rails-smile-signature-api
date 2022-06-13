require 'rails_helper'

RSpec.describe User, type: :model do

  subject {
    described_class.new(
      email: 'bork@gmail.com',
      username: 'boopybork',
      password: 'password',
      role: 'patient'
    )
  }

  before(:each) do
    @user = User.create!(
      email: 'boop@test.com', 
      username: 'borkybork',
      password: 'password',
      role: 'patient'
      )

    @services = { "services" => ["somestring1", "somestring2"] }

    @dentist = User.create!(
      email: 'dentist@gmail.com',
      username: 'imadentist',
      password: 'password',
      role: 'dentist'
    )

    @appointment_params = {
      services: @services.values,
      schedule_date: Date.parse('29/06/2022'),
      branch: 'marcos-alvarez',
      dentist_id: @dentist.id,
      schedule_time: Time.parse('13:00')
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
      branch: 'marcos-alvarez',
      tooth: [15, 16, 17],
      dentist_id: @dentist.id,
      services: @services.values,
      remarks: 'some remarks'
    }

  end


  context 'validating user creation' do
    it 'should create a valid user' do
      expect(subject).to be_valid
    end

    it 'is not valid without username' do
      subject.username = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without password' do
      subject.password = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid if username length is less than 6' do
      subject.username = 'bork'

      expect(subject).not_to be_valid
    end

    it 'is not valid if username is not unique' do

      user1 = User.new(
        email: 'boop@gmail.com',
        username: 'borkybork',
        password: 'password',
        role: 'patient'
      )

      expect(user1).not_to be_valid
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
      subject.set_appointment('Boopy', 'Bork', @appointment_params)
      appointment = Appointment.find_by(patient_id: subject.id)

      expect(appointment).not_to be_nil
    end

    it 'can create a profile' do
      @user.create_profile(@profile_params)
      profile = Profile.find_by(user_id: @user.id)

      expect(profile).not_to be_nil
    end

    it 'can generate a record' do
      profile = @user.create_profile(@profile_params)
      @dentist.create_record(@user.id, @record_params)
      record = PatientRecord.find_by(patient_id: @user.id)

      expect(record).not_to be_nil
    end
  end
end