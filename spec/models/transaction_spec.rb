require 'rails_helper'

RSpec.describe Transaction, type: :model do

  before(:each) do
    @patient = User.create(
      email: 'new@user.com',
      password: 'password',
      role: 'patient'
    )

    @dentist = User.create!(
      email: 'dentist@gmail.com',
      password: 'password',
      role: 'dentist'
    )
    
    @services = ['tooth extraction', 'basic cleaning']

    @transaction_params = {
      patient_id: @patient.id,
      services: @services,
      status: 'partial',
      branch: 'main',
      amount: 500,
      remaining: 0,
      payment_type: 'cash'
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

    @patient.create_profile(@profile_params)
  end

  subject {
    described_class.new(
      patient_id: @patient.id,
      services: @services,
      status: 'partial',
      branch: 'main',
      amount: 500,
      remaining: 0,
      payment_type: 'cash'
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

    it 'is not valid without payment_type' do
      subject.payment_type = nil

      expect(subject).not_to be_valid
    end
  end

    context 'associations' do
      it { should belong_to(:user) }
    end


    it 'generates a transaction record' do
      Transaction.create_transaction(@transaction_params)
      
      expect(Transaction.first).not_to be_nil
    end

    it 'edits a transaction record' do
      transaction = Transaction.create!(@transaction_params)
      transaction.update!(status: 'full')

      expect(transaction.status).to eq('full')
    end
end 