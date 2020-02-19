# frozen_string_literal: true

class UsersController < ApplicationController
  def new; end
  def index; end
  def create; end
  def show;
    @user = User.find(params[:id])
  end
  def update; end
  def destroy; end
end
