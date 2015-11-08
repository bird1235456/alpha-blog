class UsersController < ApplicationController
  before_action :set_users, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome to Alpha Blog #{@user.username}"
      redirect_to articles_path
    else
      set_action_variables("created")
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your Account was successfully updated"
      redirect_to articles_path
    else
      set_action_variables("updated")
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      flash[:danger] = "Account was successfully deleted"

      redirect_to articles_path
    else
      render 'show'
    end
  end

  private
  def set_action_variables(crud)
      @crud_action = crud
      @narrative = "account"
  end

  def set_users
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end