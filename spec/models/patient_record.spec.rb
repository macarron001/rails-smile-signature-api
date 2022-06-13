require 'rails_helper'

RSpec.describe PatientRecord, type: :model do

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

    @record_params = {
      patient_id: @patient.id,
      first_name: 'Bork',
      last_name: 'Testing',
      branch: 'main',
      dentist_id: @dentist.id,
      services: ['tooth extraction', 'basic cleaning'],
      remarks: "some notes"
    }

    @profile_params = {
      user_id: @patient.id,
      first_name: 'Boopy',
      last_name: 'Bork',
      date_of_birth: Date.parse('12/02/1985'),
      sex: 'male',
      mobile: '09193632424',
      address: 'Las Pinas'
    }

    @services = ['tooth extraction', 'basic cleaning']
    @patient.create_profile(@profile_params)
  end

  subject {
    described_class.new(
      patient_id: @patient.id,
      first_name: 'Bork',
      last_name: 'Testing',
      branch: 'main',
      dentist_id: @dentist.id,
      services: @services,
      remarks: "some notes"
    )
  }

  context 'validations' do

    it 'should create a valid record' do
      expect(subject).to be_valid
    end

    it 'is not valid without dentist id' do
      subject.dentist_id = nil

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
  end

  it 'should create a valid record' do
    @dentist.create_record(@patient.id, @record_params )

    expect(PatientRecord.all.count).to eq(1)
  end

  it 'should edit a record' do
    subject.update!(first_name: 'Boopy')

    expect(subject.first_name).to eq('Boopy')
  end
end