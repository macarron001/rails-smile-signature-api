require 'rails_helper'

RSpec.describe Appointment, type: :model do

  before(:each) do
    @patient = User.create(
      email: 'patient@user.com',
      password: 'password',
      role: 'patient'
    )

    @dentist = User.create(
      email: 'dentist@user.com',
      password: 'password',
      role: 'dentist'
    )

    @services = ['tooth extraction', 'basic cleaning']

    @appointment_params = [
      schedule: Time.now,
      patient_id: @patient_id,
      first_name: 'Bork',
      last_name: 'Testing',
      branch: 'Main',
      services: @services,
      dentist_id: @dentist.id,
      time: '2:00 PM'
    ]

  end

  subject {
    described_class.new(
      schedule: Time.now,
      patient_id: @patient.id,
      first_name: 'Bork',
      last_name: 'Testing',
      mobile: '09196966969'
      branch: 'Main',
      services: @services,
      dentist_id: @dentist.id,
      time: '2:00 PM'
    )
  }

  context 'validations' do
    it 'should create a valid record' do
      expect(subject).to be_valid
    end

    it 'is not valid without patient id' do
      subject.patient_id = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without first name' do
      subject.first_name = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without last name' do
      subject.last_name = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without a branch' do
      subject.branch = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without services' do
      subject.services = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without date' do
      subject.date = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without time' do
      subject.time = nil

      expect(subject).not_to be_valid
    end
  end

  context 'associations' do
    it { should have_one(:profile) }
    it { should have_many(:services) }
  end

  context 'availability' do
    it 'checks for available schedule' do
      available = Appointment.availability(@dentist_id)

      expect(available.count).to be > 0 
    end
  end

  it 'should allow patient to set an appointment' do
    @patient.set_appointment(@appointment_params)

    expect(@patient.appointments.count).to eq(1)
  end

  context 'staff capabilities' do
    it 'should edit the appointment' do
      @subject.update!(time: '4:00 PM')

      expect(@subject.time).to eq('4:00 PM')
    end

    it 'should delete the appointment' do
      @subject.destroy

      expect(@subject).not_to exist
    end
  end
end