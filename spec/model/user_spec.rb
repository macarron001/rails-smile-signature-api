require 'rails_helper'

RSpec.describe User, type: :model do

  subject {
    described_class.new(
      email: 'new@user.com',
      password: 'password'
    )
  }

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

    it "has many records" do
      should respond_to(:patient_records)
    end

    it "has a profile" do
      should respond_to(:profile)
    end

    context 'validating user capabilities'
      it 'can set an appointment' do
        subject.set_appointment

        expect (subject.appointments.count).to eq 1
      end

      it 'can create a profile' do
        subject.create_profile

        expect (subject.profiles).to exist
      end

      it 'can generate a record' do
        subject.create_record

        expect (subject.records).to exist
      end
    end
  end