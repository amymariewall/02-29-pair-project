class User < ActiveRecord::Base


  def set_errors
    errors = {}
    if self.first_name == ""
      # Add first name related error to the hash.
      errors["first_name"] = "First name cannot be blank"
    end

    if self.last_name == ""
      # Add last name related error to the hash.
      errors["last_name"] = "Last name cannot be blank"
    end


    # else 
    #   User.where.not({"id" => self.id}).find_by_email(self.email) != nil
    #   errors << "Email is already in use by another account"
    if self.email.scan("@") == []
      errors << "You did not enter a valid email address"
    end
    
    if self.password == ""
      errors << "Password cannot be blank"
    end

    return errors
  end

  def get_errors
    errors = self.set_errors
    return errors
  end

  def is_valid
    if self.get_errors == []
    return true
    else
    return false
    end 
  end
end



