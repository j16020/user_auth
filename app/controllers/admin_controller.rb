class AdminController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  def index
    @users = AdminUser.all
  end
  def new
    @user = AdminUser.new
  end
  def show
    @user = AdminUser.find(params[:id])
  end
  def create
    @user = AdminUser.new(name: params[:admin_user][:name], mail: params[:admin_user][:mail],password: params[:admin_user][:password], password_confirmation: params[:admin_user][:password_confirmation])
    if @user.save
      flash[:success] = "メールを送信しました。MCIDを登録してください"
      redirect_to admin_index_path
    else
      render :action => "new"
    end
  end
  def edit
    @user = AdminUser.find(params[:id])
  end
  def update
    @user = AdminUser.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールをアップデートしました"
      redirect_to admin_index_path
    else
      render 'edit'
    end
  end
  def user_params
    params.require(:admin_user).permit(:name, :mail, :password,
                                 :password_confirmation)
  end
  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください"
      redirect_to login_url
      end
    end
  # 正しいユーザーかどうか確認
  def correct_user
    @user = AdminUser.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
