class Investment < ActiveRecord::Base

# Gets the Investor from an Investment Object
# Returns a User object
  def access_investor
    investor_id = self.investor_user_id
    investor = User.find_by_id(investor_id)
    return investor
  end

  def access_student
    student_id = self.student_user_id
    student = User.find_by_id(student_id)
    return student
  
  end

end