class MailUserController < ApplicationController
  before_action :logged_in_user, only: [:new, :show,:create]
  def new
  end
  def show
    @users = User.all
  end
  def create
    @param = params[:body].split(/\R/)
    @message = ""
    @array = []
    @param.each do |mail|
      if mail.match? /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        pass = [*'A'..'Z', *'a'..'z', *0..9].tap { |a| break 8.times.map { a.sample }.join }
        user = User.new do |u|
          u.uuid = SecureRandom.uuid
          u.mail = mail
        end
        if user.save
          @array.push({data: user,result: "OK",style:"success"})
          NotificationMailer.send_mail_to_uuid_to_user(user).deliver
        else
          @array.push({data: user,result: "Database error",style:"danger"})
          @message = "error"
        end
      else
        user = User.new do |u|
          u.uuid ="None"
          u.mail = mail
        end
          @array.push({data: user,result: "Mail Error",style:"danger"})
      end
    end
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
