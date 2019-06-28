module SessionHelper
    def log_in(user)
        session[:user_id] = user.id
    end
    # ユーザーのセッションを永続的にする
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end
    # 現在ログイン中のユーザーを返す (いる場合)
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= AdminUser.find_by(id: session[:user_id])
            #return "/admin/#{@current_user.id}"
        elsif (user_id = cookies.signed[:user_id])
            user = AdminUser.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                #return "/admin/#{user.id}"
            end
        end
    end

    # 渡されたユーザーがログイン済みユーザーであればtrueを返す
    def current_user?(user)
        user == current_user
    end

    def current_user_path
        if (user_id = session[:user_id])
            @current_user ||= AdminUser.find_by(id: session[:user_id])
            return "/admin/#{@current_user.id}"
        elsif (user_id = cookies.signed[:user_id])
            user = AdminUser.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                return "/admin/#{user.id}"
            end
        end
    end
    # ユーザーがログインしていればtrue、その他ならfalseを返す
    def logged_in?
        !current_user.nil?
    end
    # 永続的セッションを破棄する
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end
    # 現在のユーザーをログアウトする
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end
    # 記憶したURL (もしくはデフォルト値) にリダイレクト
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end

    # アクセスしようとしたURLを覚えておく
    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end
    
    def joinUserCount(eventid)
        Event.joins(:user).where(eventid: params[:id]).count
    end
end
