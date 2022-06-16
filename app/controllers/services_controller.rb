class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin, except: [:available_services]

  def create_service
    service = current_user.create_service(service_params)

    render json: json = {
      status: 201, 
      message: `Service added!`,
      service: service,
    }, status: :ok
  end

  def index
    service = Service.all

    render json: service
  end

  def service_details
    service = Service.find_by(name: params:[name])

    render json: service
  end

  def update
    if @service.update(service_params)
      render json: json = {
        status: 201, 
        message: 'Service updated!',
        service: service,
      }, status: :ok
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  def remove_service
    current_user.remove_service(params:[:name])

    render json: json = {
      status: 201, 
      message: `Service removed!`
    }, status: :ok
  end


  private
  
  def service_params 
    params.require(:service).permit(:name, :price, :branch)
  end

  def set_service
    @service = Service.find(params[:id])
  end

  def authenticate_admin
    render json: json = {
      status: 401, 
      message: 'Unauthorized user.',
    }, status: :unauthorized unless current_user.role == 'admin'
  end
end
