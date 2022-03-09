# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.order(:id).page(params[:page]).with_attached_avatar
    render 'followings'
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.order(:id).page(params[:page]).with_attached_avatar
    render 'followers'
  end
end
