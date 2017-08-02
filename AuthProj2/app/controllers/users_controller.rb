class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to "/sessions/new"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/new"
    end
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update(user_params)
      redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/#{@user.id}/edit"
    end

  end

  private
  def user_params
    params.require(:user).permit( :name, :email, :password, :ConfirmPassword)
  end

end
