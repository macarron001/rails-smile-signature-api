require 'rails_helper'

RSpec.describe Service, type: :model do

  before(:each) do
    @admin = User.create!(
      email: 'new@admin.com',
      password: 'password',
      role: 'admin'
    )
    
    @service_params = {
      name: 'Tooth Extraction',
      price: 500,
      branch: 'all'
    }
  end

  subject {
    described_class.new(
      name: 'Tooth Extraction',
      price: 500,
      branch: 'all'
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

  context 'admin capabilities' do
    it 'should be able to create a service' do
      @admin.create_service(@service_params)

       expect(Service.all.count).to eq(1)
    end

    it 'should be able to edit a service' do
      service = @admin.create_service(@service_params)
      service.update!(price: 600)

      expect(service.price).to eq(600)
    end

    it 'should be able to delete a service' do
      service = @admin.create_service(@service_params)
      service.delete
      
      expect(Service.first).to eq(nil)
    end
  end
end