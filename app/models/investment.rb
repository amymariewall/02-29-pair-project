# The Investment table contains columns for:
#
#id
#investor_user_id - integer
#student_user_id - integer
#amount - float
#paid - boolean

class Investment < ActiveRecord::Base

# Gets the Investor from an Investment Object
# Returns a User object
  def access_investor
    investor_id = self.investor_user_id
    investor = User.find_by_id(investor_id)
    return investor
  end

# Gets the Student from an Investment Object
# Returns a User object  

  def access_student
    student_id = self.student_user_id
    student = User.find_by_id(student_id)
    return student
  end

# Sets @errors to an empty array

  def initialize_errors_array
    @errors = []
  end

# Adds message to @errors if amount entered is 0

  def set_wrong_amount_errors
    if self.amount == 0
      @errors << "Amount can't be 0"
    end
  end

# Adds message to @errors if amount entered is greater than the student's debt 

  def set_excessive_amount_errors
    amount = self.amount
    if amount != nil 
      user = User.find_by_id(self.student_user_id)
       if user.debt_amount < amount
         @errors << "Amount exceeds debt amount"
       end
    end
  end

# Adds message to @errors if user doesn't enter an amount

  def set_blank_entry_errors
    if amount.blank?
      @errors << "Please enter a valid amount"
    end
  end

# Runs through all the @error setter methods that collect errors into @error 

  def set_errors
    self.initialize_errors_array
    self.set_wrong_amount_errors
    self.set_excessive_amount_errors
    self.set_blank_entry_errors
  end

# Returns an Array of error messages

  def get_errors
    return @errors
  end

# Adds error messages to the error Array, @errors
# Returns true if there are no errors and the Array of errors is empty
# Returns false if there are errors and the Array of errors has messages in it 

  def is_valid
    self.set_errors
    if self.get_errors == []
    return true
    else
    return false
    end 
  end

end