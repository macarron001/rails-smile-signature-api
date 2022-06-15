class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user

  def create
    user = @user.create_profile(profile_params)

    render json: json = {
      status: 201, 
      message: `Profile created!`,
      profile: user,
    }, status: :ok
  end

  def edit
    profile = Profile.find_by(user_id: @user.id)
    profile.update!
  end

  private

  def profile_params 
    params.require(:profile).permit(:first_name, :last_name, :date_of_birth, :sex, :mobile, :address)
  end

  def get_user
    @user = current_user
  end
end
