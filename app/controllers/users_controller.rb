class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # 成功した場合、アプリケーションのルートにリダイレクト
      redirect_to root_path, notice: "ユーザー登録が完了しました"
    else
      # エラーをコンソールに出力
      puts @user.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
