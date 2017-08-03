class SecretsController < ApplicationController
  def index
    @secrets = Secret.all
  end

  def create
    @secret = Secret.new(secret_params)
    if @secret.save
      redirect_to "/users/#{current_user.id}"
    else
      flash[:errors] = @secret.error.full_messages
      redirect_to :back
    end
  end

  def destroy
    @secret = Secret.find_by_id(params[:id])
    if @secret.destroy
      redirect_to "/secrets"
    else
      flash[:errors] = @secret.error.full_messages
      redirect_to "/secrets"
    end
  end

  def like
    puts "*********************************"
    puts params[:secret_id]
    puts params[:toggle]
    puts current_user.id
    puts "-------------------------------"
    if params[:toggle] == "fa fa-thumbs-up"
        @like = Like.new(user:current_user,secret:Secret.find_by_id(params[:secret_id]))
        if @like.save
            puts "comes here"
            json_message = {:status => "success" ,:message => "done"}
            render json: json_message
        else
            json_message = {:status => "error", :message => "error"}
            render json: json_message
        end
    else
        @like = Like.where("user_id=#{current_user.id} and secret_id=#{params[:secret_id]}")
        if @like.destroy_all
           json_message = {:status => "success" ,:message => "done"}
           render json: json_message
        else
          json_message = {:status => "error", :message => "error"}
          render json: json_message
        end
    end

  end

  private
  def secret_params
    params.require(:secret).permit(:content,:user_id)
  end
end
