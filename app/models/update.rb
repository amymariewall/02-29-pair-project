#this sets active record to our Update class. Columns are "user_id" and "status_update".

class Update < ActiveRecord::Base
  def time_display
    return (Time.now - self.created_at.to_time).to_i/60 
  end

  # @update = Update.where...
  # @update.time_display
end