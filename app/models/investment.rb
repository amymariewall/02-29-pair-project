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

  def set_errors(user)
    errors = []
    if self.amount == 0
      errors << "Amount can't be 0"
    end

    if self.amount == ""
      errors << "Please enter a valid amount"
    end

    # if self.amount != nil
    #   if user.debt_amount < self.amount
    #     errors << "Amount exceeds debt amount"
    #   end
    # end
  end

  def get_errors(user)
    errors = self.set_errors(user)
    return errors
  end

  def is_valid(user)
    if self.get_errors(user) == []
    return true
    else
    return false
    end 
  end

end