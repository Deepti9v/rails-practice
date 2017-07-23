class ProfileController < ApplicationController
  def new
  end

  def create
    @profile = Profile.create(profile_params)
    session[:count] ||= 0
    session[:count] = session[:count] + 1
    session[:data] = params[:profile]
    flash[:success] = "Thanks for submitting the form"
    redirect_to "/profile/show"
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  private
  def profile_params
    params.require(:profile).permit(:email,:name,:location,:comment)
  end
end
