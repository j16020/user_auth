require "#{Rails.root}/app/models/user"

class Tasks::Userlist
    def self.output
        user = User.where.not(mcid:nil)
        File.open("/mnt/windows/testuser.txt","w") do |text|
            user.each do |u|
                text.puts(u.mcid)
            end
        end
    end
end