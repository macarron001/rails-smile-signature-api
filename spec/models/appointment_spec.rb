require 'rails_helper'

RSpec.describe Appointment, type: :model do

  before(:each) do
    @staff = User.create(
      email: 'patient@user.com',
      password: 'password',
      role: 'staff'
    )

    @dentist = User.create(
      email: 'dentist@user.com',
      password: 'password',
      role: 'dentist'
    )

    @services = ['tooth extraction', 'basic cleaning']

    @appointment_params = {
      branch: 'marcos-alvarez',
      schedule_date: Date.parse('29/06/2022'),
      schedule_time: Time.parse('13:00'),
      first_name: 'Bork',
      last_name: 'Borky',
      mobile: '0915549323',
      services: @services
    }

  end

  subject {
    described_class.new(
      user_id: @dentist.id,
      branch: 'marcos-alvarez',
      schedule_date: Date.parse('29/06/2022'),
      schedule_time: Time.parse('13:00'),
      first_name: 'Bork',
      last_name: 'Borky',
      mobile: '0915549323',
      services: @services
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
    it { should belong_to(:user) }
  end

  context 'availability' do
    it 'checks for available schedule' do
      available = Appointment.schedule_available?(Time.now, Time.parse('4:00 PM'), 'main')

      expect(available).to eq(true) 
    end
  end

  it 'should allow patient to set an appointment' do
    @dentist.set_appointment(@appointment_params)

    expect(@dentist.appointments.count).to eq(1)
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