class UserPresenter
  def initialize(user)
    @user = user
  end

  def status_updates_header(current_user_id)
    if @user.id == current_user_id
      "Your status updates"
    else
      "#{@user.first_name}'s status updates"
    end
  end


end