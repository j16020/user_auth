class NotificationMailer < ActionMailer::Base
    default from: "ratami.seikatsu@gmail.com"
    #メールアドレスから一括でUUIDを生成して送信する
    def send_mail_to_uuid_to_user(user)
        @user = user
        mail(
            subject: "テスト",
            to: @user.mail
        ) do |format|
        format.text
        end
    end
    #メールアドレスから一括でUUIDを生成して送信する
    def send_mail_to_mcid_to_user(user)
        @user = user
        mail(
            subject: "テスト",
            to: @user.mail
        ) do |format|
        format.text
        end
    end
end
