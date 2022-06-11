require 'rails_helper'

RSpec.describe Profile, type: :model do

  before(:each) do
    @user = User.create(
      email: 'new@user.com',
      password: 'password'
    )
  end

  subject {
    described_class.new(
      user_id: @user.id,
      first_name: 'Bork',
      last_name: 'Testing',
      date_of_birth: Time.now,
      sex: 'Male',
      mobile: '09196966969',
      address: 'Las Pinas',
      last_visit: Time.now
    )
  }

  context 'validations' do

    it 'should create a valid profile' do
      expect(subject).to be_valid
    end

    it 'is not valid without user id' do
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

    it 'is not valid without DOB' do
      subject.date_of_birth = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without sex' do
      subject.sex = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without mobile' do
      subject.mobile = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without address' do
      subject.address = nil

      expect(subject).not_to be_valid
    end
  end

  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:appointment) }
    it { should belong_to(:transaction) }
    it { should belong_to(:patient_record) }
  end

  it 'should be able to edit details' do
    subject.update!(first_name: 'Boopy')

    expect(subject.first_name).to eq('Boopy')
  end
end