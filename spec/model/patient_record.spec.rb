require 'rails_helper'

RSpec.describe Profile, type: :model do

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
  end

  subject {
    described_class.new(
      patient_id: @user.id,
      first_name: 'Bork',
      last_name: 'Testing',
      branch: 'Main',
      dentist_id: @dentist.id,
      services: @services,
      remarks: "some notes"
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

  context 'associations' do
    it { should have_one(:profile) }
    it { should have_many(:services) }
  end

  it 'should create a valid record' do
    @dentist.create_record(subject.args)

    expect(@patient.records.count).to eq(1)
  end

  it 'should edit a record' do
    subject.update!(first_name: 'Boopy')

    expect(subject.first_name).to eq('Boopy')
  end
end