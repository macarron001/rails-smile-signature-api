require 'rails_helper'

RSpec.describe Transaction, type: :model do

  before(:each) do
    @patient = User.create(
      email: 'new@user.com',
      password: 'password'
    )
    
    @services = ['tooth extraction', 'basic cleaning']

    @record_params = (
      patient_id: @user.id,
      first_name: 'Bork',
      last_name: 'Testing',
      branch: 'Main',
      dentist_id: @dentist.id,
      services: @services,
      remarks: "some notes"
    )
  end

  subject {
    described_class.new(
      patient_id: @patient.id,
      services: @services,
      status: 'partial',
      branch: 'main',
      amount: 500,
      remaining: 0,
      type: 'cash'
    )
  }

  context 'validations' do
    it 'should create a valid record' do
      expect(subject).to be_valid
    end

    it 'is not valid without a patient id' do
      subject.patient_id = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without services' do
      subject.services = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without status' do
      subject.status = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without branch' do
      subject.branch = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without amount' do
      subject.amount = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without remaining' do
      subject.remaining = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without type' do
      subject.type = nil

      expect(subject).not_to be_valid
    end
  end

    context 'associations' do
      it { should have_one(:profile) }
      it { should have_many(:services) }
    end


    it 'generates a transaction record' do
      @user.create_record(@record_params)
      
      expect(@user.transactions.count).to eq(1)
    end

    it 'edits a transaction record' do
      @subject.update!(status: 'full')

      expect(@subject.status).to eq('full')
    end
end 