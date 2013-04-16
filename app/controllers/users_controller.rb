class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def index
    # We only want to make available the users
    # that are visible on the current page
    # using the will_paginate gem.
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      # We need to re-signin because the remember
      # token is invalidated at user save.
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

  def signed_in_user
    unless signed_in?
      # Any time an action requires being signed in
      # but the user has to sign in first the attempt
      # is stored so we can redirect there afterward.
      store_location
      redirect_to signin_url, notice: "Please sign in"
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
