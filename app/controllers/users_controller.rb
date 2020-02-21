# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_params, only: %i[edit update show destroy]

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
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
    flash[:danger] = 'User has been deleted!'
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
end
