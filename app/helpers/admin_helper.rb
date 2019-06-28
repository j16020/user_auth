module AdminHelper
    def user_count(eventid)
        Event.joins(:user).where(eventid: eventid).count
    end
end
