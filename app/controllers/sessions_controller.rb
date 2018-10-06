class SessionsController < ApplicationController
  def new
    flash[:previous_page] = request.referer
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      if flash[:previous_page]
        redirect_to flash[:previous_page], notice: "Logged in!"
      else
        redirect_to :root
      end
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    if request.referer
      redirect_to request.referer, notice: "Logged out!"
    else
      redirect_to :root, notice: "Logged out!"
    end
  end
end
