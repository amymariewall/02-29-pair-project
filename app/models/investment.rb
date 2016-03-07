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

  def initialize_errors_array
    @errors = []
  end


  def set_wrong_amount_errors
    if self.amount == 0
      @errors << "Amount can't be 0"
    end
  end


  def set_excessive_amount_errors
    amount = self.amount
    if amount != nil 
      user = User.find_by_id(self.student_user_id)
       if user.debt_amount < amount
         @errors << "Amount exceeds debt amount"
       end
    end
  end


  def set_blank_entry_errors
    amount = self.amount
    if amount.blank?
      @errors << "Please enter a valid amount"
    end
  end

  def set_errors
    self.initialize_errors_array
    self.set_wrong_amount_errors
    self.set_excessive_amount_errors
    self.set_blank_entry_errors
  end

  def get_errors
    return @errors
  end

  def is_valid
    self.set_errors
    if self.get_errors == []
    return true
    else
    return false
    end 
  end

end