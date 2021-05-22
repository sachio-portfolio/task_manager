class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :require_admin
  skip_before_action :login_required
  def index
    @users = User.select(:id, :user_name, :email, :admin,).order("created_at DESC")
  end
  def new
      @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user)
      flash[:success] = "新たなユーザー「#{@user.user_name}」が登録されました"
    else
      render :new
    end
  end
  def show
  end
  def edit
  end
  def update
    begin
      if @user.update(user_params)
        redirect_to admin_user_path(@user)
        flash[:info] = "ユーザー「#{@user.user_name}」の編集が完了しました"
      else
        render :edit
      end
    rescue RuntimeError
      redirect_to edit_admin_user_path(@user)
      flash[:warning] = "管理者権限を持つのがこのユーザーだけなので更新できません"
    end
  end
  def destroy
    begin
      @user.destroy
      redirect_to admin_users_path
      flash[:danger] = "ユーザー「#{@user.user_name}」を削除しました"
    rescue RuntimeError
      redirect_to admin_users_path
      flash[:warning] = "最後の管理者は削除できません"
    end
  end
  private
  def user_params
    params.require(:user).permit(:user_name, :email, :admin, :password, :password_confirmation,)
  end
  def set_user
    @user = User.find(params[:id])
  end
  def require_admin
    unless current_user.admin?
      redirect_to root_url
      flash[:warning] = "管理者のユーザー以外はアクセスできません"
    end
  end
end
