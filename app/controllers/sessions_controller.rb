class SessionsController < ApplicationController
  include CustomSessionBehavior

  def new; end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      cart = Cart.find(session[:cart_id])
      user.cart = cart
      user.session_counter.increment
      redirect_to session[:intended_url] || user
      session[:intended_url] = nil
    else
      flash.now[:alert] = "Invalid email/password combination!"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    puts_signout
    cart = Cart.find(session[:cart_id])
    cart.destroy
    user = User.find(session[:user_id])
    list_name = user.liked_products.key
    Kredis.list(list_name).clear #when logging out, we clear out the liked_products. not sure about that but who cares (this is for learning only)
    session[:user_id] = nil
    session[:cart_id] = nil
    # session[:counter] = nil
    # reset_session #covers nulling out session data
    confirm_fresh_sesh
    redirect_to root_url
  end
end
