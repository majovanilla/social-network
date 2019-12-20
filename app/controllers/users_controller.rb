class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[new create]

  def new
  end

  def create
  end

  def show
    @user = current_user
  end

  def index
    @users = User.all
  end
end
