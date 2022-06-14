require 'rails_helper'

RSpec.describe PatientRecord, type: :model do

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

    @record_params = {
      first_name: 'Bork',
      last_name: 'Borky',
      branch: 'marcos-alvarez',
      tooth: [15, 16, 17],
      services: @services,
      remarks: 'some remarks'
    }

  end

  subject {
    described_class.new(
      first_name: 'Bork',
      last_name: 'Borky',
      branch: 'marcos-alvarez',
      tooth: [15, 16, 17],
      services: @services,
      remarks: 'some remarks',
      user_id: @dentist.id
    )
  }

  context 'validations' do

    it 'should create a valid record' do
      expect(subject).to be_valid
    end

    it 'is not valid without user_id' do
      subject.user_id = nil

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
    @dentist.create_record(@record_params )

    expect(@dentist.patient_records.count).to eq(1)
  end

  it 'should edit a record' do
    subject.update!(first_name: 'Boopy')

    expect(subject.first_name).to eq('Boopy')
  end
end