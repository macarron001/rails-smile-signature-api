class CurrentUserController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin, except: [:index, :update_email, :update_password]

  def index
    render json: current_user, status: :ok
  end

  def staff
    staff = User.where.not(role: 'admin')
    
    render json: staff
  end
  
  def dentist
    dentist = User.all.where(role: 'dentist')

    render json: dentist
  end

  def create
    user = User.create!(user_params)
    
    render json: json = {
      status: 201, 
      message: "User registered!",
      user: user.email,
      role: user.role
    }, status: :ok
  end

  def update_password
    value = params[:value]
    current_user.update!(password: value)
  end

  private

  def user_params 
    params.require(:user).permit(:email, :password, :role)
  end

  def authenticate_admin
    render json: json = {
      status: 401, 
      message: 'Unauthorized user.',
    }, status: :unauthorized unless current_user.role == 'admin'
  end
end