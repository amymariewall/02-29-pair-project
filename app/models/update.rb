#this sets active record to our Update class. Columns are "user_id" and "status_update".

class Update < ActiveRecord::Base

  def display_minute(min_ago)
    min_ago.to_s + " minute ago"
  end

  def display_minutes(min_ago)
    min_ago.to_s + " minutes ago"
  end

  def display_hour(min_ago)
    "About one hour ago"
  end

  def display_hours(min_ago)
    (min_ago/60).to_s + " hours ago"
  end

  def display_day
    "One day ago"
  end

  def display_days(min_ago)
    (min_ago/1440).to_s + " days ago"
  end

  def posted_ago
    min_ago = (Time.now - self.created_at.to_time).to_i/60 
    if min_ago < 60 && min_ago != 1
      return self.display_minutes(min_ago)
    elsif min_ago == 1
      return self.display_minute(min_ago)
    elsif min_ago.floor < 120
      return self.display_hour(min_ago)
    elsif min_ago > 120 && min_ago < 1440
      return self.display_hours(min_ago)
    else
      if (min_ago/1440).floor == 1
        return self.display_day
      else
        return self.display_days(min_ago)
      end
    end
  end

end