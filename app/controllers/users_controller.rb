class UsersController < ApplicationController
  #before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users/1
  def show
    @user = current_user
    @tweets = Tweet.all
  end
end



