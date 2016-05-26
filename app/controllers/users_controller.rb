class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show # 追加
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  @user = User.find(params[:id])
   if current_user != @user
      redirect_to:root
   end
  end


  def update
   @user = User.find(params[:id])
    if current_user != @user
       redirect_to:root
    end
    if @user.update(user_params)
      flash[:success] = "Up date!"
      redirect_to @user
    end
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.follower_users
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.following_users
  end

    


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :profile, :area)
  end
end
