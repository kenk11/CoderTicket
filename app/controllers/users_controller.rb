class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = 'Register successful!'
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = "Error: #{@user.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
