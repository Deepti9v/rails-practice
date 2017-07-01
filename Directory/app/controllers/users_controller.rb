class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  def index
    @users = User.all
  end

  def new
    @user = User.new
    render "new"
  end

  def create
    #User.create(name:params[:name],occupation:params[:occupation])
    #@user = User.new(params[:user])
    @user = User.new(user_params)
    @user.save
    redirect_to "/users"
  end


  def edit
  end

  def update
    if @user.update_attributes(user_params)
        redirect_to "/users"
    end
  end

  def show
  end

  def destroy
  end

  def user_params
    params.require(:user).permit(:name, :occupation, :photo)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
