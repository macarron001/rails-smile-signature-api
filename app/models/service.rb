class Service < ApplicationRecord

  validates :name, presence: true
  validates :price, presence: true, numericality: {greater_than: 0}
  validates :branch, presence: true, :inclusion => { :in => ['marcos-alvarez', 'almanza', 'all']}

  def self.create_service(service_params)
    Service.create!(
      :name => service_params[:name],
      :price => service_params[:price],
      :branch => service_params[:branch]
    )
  end
end
