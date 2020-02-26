# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_params, only: %i[edit update show destroy]
  before_action :logged_in_user, only: %i[edit update]
  before_action :correct_user, only: %i[edit update]

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'User updated succesfully!'
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash.now[:danger] = 'User has been deleted!'
    redirect_to users_path
  end

  private

  def set_params
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name,
                                 :email, :password,
                                 :password_confirmation)
  end

  # Confirms a logged-in user.
  def logged_in_user
    redirect_to login_url unless logged_in?
    flash[:danger] = 'Please log in.' unless logged_in?
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
    flash[:danger] = 'Forbidden' unless current_user?(@user)
  end
end
