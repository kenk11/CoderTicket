class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :callback]

  def new

  end

  def create
    if @user = User.find_by(email: params[:email]) and @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = 'Signed in'
      redirect_to root_path
    else
      flash.now[:error] = 'Invalid username or password'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Logged out.'
    redirect_to root_path
  end


  def callback
    if user = User.from_facebook(env["omniauth.auth"]) # log in user here else # don't log user in end
      session[:user_id] = user.id
      redirect_to root_path
    else
      # flash[:error] = 'Error while logging in Facebook!'
      redirect_to root_path
    end

  end

end
