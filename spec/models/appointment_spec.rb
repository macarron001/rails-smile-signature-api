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

    @appointment_params = {
      schedule_date: Time.now,
      patient_id: @patient_id,
      first_name: 'Bork',
      last_name: 'Testing',
      branch: 'Main',
      services: @services,
      dentist_id: @dentist.id,
      schedule_time: '2:00 PM'
    }

  end

  subject {
    described_class.new(
      schedule_date: Time.now,
      patient_id: @patient.id,
      first_name: 'Bork',
      last_name: 'Testing',
      mobile: '09196966969',
      branch: 'main',
      services: @services,
      dentist_id: @dentist.id,
      schedule_time: '2:00 PM'
    )
  }

  context 'validations' do
    it 'should create a valid record' do
      expect(subject).to be_valid
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
      subject.schedule_date = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without time' do
      subject.schedule_time = nil

      expect(subject).not_to be_valid
    end
  end

  context 'associations' do
    it { should belong_to(:patient) }
  end

  context 'availability' do
    it 'checks for available schedule' do
      available = Appointment.schedule_available?(Time.now, Time.parse('4:00 PM'), 'main')

      expect(available).to eq(true) 
    end
  end

  it 'should allow patient to set an appointment' do
    @patient.set_appointment(@appointment_params)

    expect(Appointment.all.count).to eq(1)
  end

  context 'staff capabilities' do
    it 'should edit the appointment' do
      subject.update!(branch: 'Marcos Alvarez')

      expect(subject.branch).to eq('Marcos Alvarez')
    end

    it 'should delete the appointment' do
      subject.destroy

      expect(Appointment.first).to eq(nil)
    end
  end
end