require 'rails_helper'

RSpec.describe Profile, type: :model do

  before(:each) do
    @admin = admin.create(
      email: 'new@admin.com',
      password: 'password',
      role: 'admin'
    )
  end

  subject {
    described_class.new(
      name: 'Tooth Extraction',
      description: 'pulling a tooth',
      price: 500,
      branch: 'all',
    )
  }

  context 'validations' do
    it 'should create a valid record' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without a price' do
      subject.price = nil

      expect(subject).not_to be_valid
    end

    it 'is not valid without a branch' do
      subject.branch = nil

      expect(subject).not_to be_valid
    end
  end

  context 'associations' do
    it { should belong_to(:appointment) }
    it { should belong_to(:transaction) }
    it { should belong_to(:patient_record) }
  end

  context 'admin capabilities' do
    it 'should be able to create a service' do
      @admin.create_service(
        'Multiple Tooth Extraction', 
        'pooling a set of teeth',
        1500,
        'all'
       )

       expect(Service.all.count).to eq(1)
    end

    it 'should be able to edit a service' do
      @subject.update!(price: 600)

      expect(@subject.price).to eq(600)
    end

    it 'should be able to delete a service' do
      @subject.destroy

      expect(@subject).not_to exist
    end
  end
end