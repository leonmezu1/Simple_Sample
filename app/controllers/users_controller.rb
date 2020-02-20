# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_params, only: %i[edit update show destroy]

  def new
    @user = User.new
  end

  def index; end

  def create; end

  def show; end

  def update; end

  def destroy; end

  private

  def set_params
    @user = User.find(params[:id])
  end
end
