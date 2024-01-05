class UsersController < ApplicationController
  before_action :require_signin, except: %i[new create]
  before_action :require_correct_user, only: %i[edit update destroy]

  include CustomSessionBehavior

  def index
    @users = User.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session = SessionStore.new(request)
      session[:user_id] = @user.id
      puts "+++++++++++++++++++++++++++++"
      session.puts_something
      cart = Cart.find(session[:cart_id])
      @user.cart = cart
      @user.session_counter.increment
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Account successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    session[:cart_id] = nil
    # reset_session #clear all session data and generates new sesh
    confirm_fresh_sesh 
    redirect_to root_url, alert: "Account successfully deleted!"
  end

private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end
end
