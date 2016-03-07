class User < ActiveRecord::Base


  def set_errors
    problems = []
    if self.first_name == ""
      problems << "First name cannot be blank"
    end

    if self.last_name == ""
      problems << "Last name cannot be blank"
    end

    if self.email == ""
      problems << "Email cannot be blank"
    end


    # else 
    #   User.where.not({"id" => self.id}).find_by_email(self.email) != nil
    #   errors << "Email is already in use by another account"
    if self.email.scan("@") == []
      problems << "You did not enter a valid email address"
    end
    
    if self.password == ""
      problems << "Password cannot be blank"
    end

    return problems
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



