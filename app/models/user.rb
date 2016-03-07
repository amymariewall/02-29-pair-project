class User < ActiveRecord::Base
#this class contains all of our methods to set errors

  def set_errors
    @errors = []
    if self.first_name == ""
      # Add first name related error to the hash.
      @errors << "First name cannot be blank"
    end

    if self.last_name == ""
      # Add last name related error to the hash.
      @errors << "Last name cannot be blank"
    end

    if self.email == ""
      @errors << "Email cannot be blank"
    end
  end


    # else 
    #   User.where.not({"id" => self.id}).find_by_email(self.email) != nil
    #   errors << "Email is already in use by another account"

  def set_errors_verification
    if self.email.scan("@") == []
      @errors << "You did not enter a valid email address"
    end
    
    if self.password == ""
      @errors << "Password cannot be blank"
    end
  end

  def get_errors
    self.set_errors
    self.set_errors_verification
    return @errors
  end

  def is_valid
    if self.get_errors == []
    return true
    else
    return false
    end 
  end
end