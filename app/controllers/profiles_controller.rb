class ProfilesController < ApplicationController
  # before_action :authenticate_user!
  # before_action :get_user

  def create_profile
    # profile = @user.create_profile(profile_params)
    profile = Profile.create(profile_params)

    render json: json = {
      status: 201, 
      message: 'Profile created',
      profile: profile,
    }, status: :ok
  end

  def show_profile
    profile = Profile.find_by(user_id: params[:id])

    render json: json = {
      status: 201, 
      message: 'Here is your profile',
      profile: profile,
    }, status: :ok
  end

  def update_profile
    profile = Profile.find_by(user_id: @user.id)
    
    if profile.update(profile_params)
      render json: json = {
        status: 201, 
        message: 'Profile updated!',
        profile: profile,
      }, status: :ok
    else
      render json: profile.errors, status: :unprocessable_entity
    end
  end

  private

  def profile_params 
    params.require(:profile).permit(:first_name, :last_name, :middle_name, :date_of_birth, :gender, :mobile, :address, :id)
  end

  def get_user
    @user = current_user
  end
end
