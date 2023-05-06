module ApplicationHelper
    def time_ago(time)
        seconds_ago = (Time.now - time).round
        minutes_ago = (seconds_ago / 60).round
        hours_ago = (minutes_ago / 60).round
        days_ago = (hours_ago / 24).round

        if seconds_ago < 60
        "#{seconds_ago} seconds ago"
        elsif minutes_ago < 60
        "#{minutes_ago} minutes ago"
        elsif hours_ago < 24
        "#{hours_ago} hours ago"
        else
        "#{days_ago} days ago"
        end
    end
end
