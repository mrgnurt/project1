class UsersController < ApplicationController
  before_action :log_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page])
  end  

  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = "User not found"
    redirect_to root_path
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to project"
      log_in @user
      redirect_to @user
    else
      render :new 
    end  
  end

  def edit
    @user = User.find_by id: params[:id]
  end 

  def update
    @user = User.find_by id: params[:id]
    if @user
      if @user.update_attributes(user_params)
         flash[:success] = "Update success"
         redirect_to @user
      else
        render :edit
      end  
    else
      flash[:danger] = "User not found"
      redirect_to root_path
    end  
  end

  def destroy
    user = User.find_by id: params[:id]
    if user
      user.destroy
      flash[:success] = "User delete"
      redirect_to users_path
    else
      flash[:danger] = "User not found"
      redirect_to root_path
    end  
  end  

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end

  def log_in_user
    unless logged_in?
      flash[:danger] = "Please log in"
      store_location
      redirect_to login_path
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    if @user
      redirect_to root_path unless current_user? @user
    else
      flash[:danger] = "User not found"
      redirect_to root_path
    end  
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end  
end
