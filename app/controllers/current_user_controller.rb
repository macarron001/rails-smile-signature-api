class CurrentUserController < ApplicationController
  # before_action :authenticate_user!
  # before_action :authenticate_admin, except: [:index, :update_email, :update_password]

  def index
    render json: current_user, status: :ok
  end

  def staff_list
    list = User.where.not(role: 'admin')
    
    render json: list
  end
  
  def dentists
    dentist = User.all.where(role: 'dentist')

    render json: dentist
  end

  def create
    user = User.create!(user_params)
    
    render json: json = {
      status: 201, 
      message: "User registered!",
      user: user.email,
      role: user.role,
      profile: user.has_profile
    }, status: :ok
  end

  def update_password
    value = params[:value]
    current_user.update(password: value)
  end

  def delete_user
    id = params[:id].to_i
    user = User.find(id)
    user.destroy

    render json: json = {
      status: 200, 
      message: "User removed!"
    }, status: :ok
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