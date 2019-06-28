require 'net/https'
class UserAuthController < ApplicationController
  def new

  end
  def usershow
    @user = User.all
  end
  def forced_create
    @user = User.find_by(mail: params[:email])
    if @user == nil
      flash.now[:error] = 'メールアドレスが登録されていません'
      render :new
      return
    end
    @user.update(mcid:params["mcid"],MissCount: @user.MissCount-1)
    flash.now[:succsess]="登録・変更に完了しました。今月の残り変更回数は"+@user.MissCount.to_s+"回です"
    render :new
  end

  def check(user)
    message = "MCIDは登録されていません。\n"
    if user.mcid
      message = "MCIDは"+user.mcid+"で登録されています。\n"
    end
    flash.now[:info] = message
  end

  def create

    @user = User.find_by(mail: params[:email],uuid: params[:uuid])

    if params[:commit]=="確認" and @user!= nil
      check(@user)
      render :new
      return 
    end

    if @user == nil
      flash.now[:danger] = 'メールアドレスもしくはUUIDが登録されていません'
      render :new
      return
    elsif @user.MissCount <= 0
      flash.now[:danger] = '今月の変更はできません'
      render :new
      return
    end

    @mcid = params[:mcid]
    uri = URI.parse("https://api.mojang.com/users/profiles/minecraft/#{@mcid}")
    @query = uri.query
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    response=http.get(uri.request_uri)
    begin
      case response
      when Net::HTTPSuccess
        if response.body != nil
          @result = JSON.parse(response.body)
          if @result["name"] == @mcid
            @user.update(mcid:@result["name"],MissCount: @user.MissCount-1)
            flash.now[:success]="登録・変更に完了しました。今月の残り変更回数は"+@user.MissCount.to_s+"回です"
            NotificationMailer.send_mail_to_mcid_to_user(@user).deliver_later
            render :new
          else
            flash[:alert_mail] = params[:email]
            flash[:alert_mcid] = params[:mcid]
            flash.now[:warning] = @mcid+"はただしいですか?\n正しい場合送信してください。"
          end
        else
          flash.now[:danger] = 'Minecraft ID Error'
          render :new
        end
      when Net::HTTPRedirection
        flash.now[:danger] = 'HTTPRedirection Error'
        render :new
      else
        flash.now[:danger] = 'Minecraft ID Error'
        render :new
      end
    end
  end
end
