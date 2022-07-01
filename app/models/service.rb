class Service < ApplicationRecord
  validates :name, presence: true
  
  def self.create_service(service_params)
    Service.create!(
      :name => service_params[:name]
    )
  end
end
