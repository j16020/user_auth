class SessionController < ApplicationController
  def new
  end
  def create
    user = AdminUser.find_by(mail: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or "/admin/#{user.id}"
      #remember user
      #redirect_to "/admin/#{user.id}"
      #redirect_to controller: 'admin', id: user.id
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'メールアドレスかパスワードが間違っています'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to "/"
  end
end
