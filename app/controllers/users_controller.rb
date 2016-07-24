class UsersController < ApplicationController

  def new
    @tickettype = User.new
  end

  def create
    @tickettype = User.new user_params
    if @tickettype.save
      flash[:success] = 'Register successful!'
      session[:user_id] = @tickettype.id
      redirect_to root_path
    else
      flash[:error] = "Error: #{@tickettype.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  private
  def user_params
    params.require(:tickettype).permit(:name, :email, :password)
  end
end
