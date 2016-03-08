require 'test_helper'

class InvestmentTest < Minitest::Test
  def setup
    super
    
    @investor = User.new
    @investor.first_name = "Warren"
    @investor.last_name = "Buffet"
    @investor.email = "bigmoney@yahoo.com"
    @investor.password = "password"
    @investor.debt_amount = 0
    @investor.save

    @student = User.new
    @student.first_name = "Marlon"
    @student.last_name = "Brando"
    @student.email = "marlonb@gmail.com"
    @student.password = "password"
    @student.debt_amount = 8000.0
    @student.save

    @student2 = User.new
    @student2.first_name = "Marie"
    @student2.last_name = "Curie"
    @student2.email = "mariecurie@gmail.com"
    @student2.password = "password"
    @student2.debt_amount = 450.0
    @student2.save


    @investment = Investment.new
    @investment.investor_user_id = @investor.id
    @investment.student_user_id = @student2.id
    @investment.amount = 500.0
    @investment.save

    @investment2 = Investment.new
    @investment2.investor_user_id = @investor.id
    @investment2.student_user_id = @student2.id
    @investment2.amount = 400.0
    @investment2.save

    @investment3 = Investment.new
    @investment3.investor_user_id = @investor.id
    @investment3.student_user_id = @student.id
    @investment3.amount = 0
    @investment3.save

    @investment4 = Investment.new
    @investment4.investor_user_id = @investor.id
    @investment4.student_user_id = @student.id
    @investment4.amount = nil
    @investment4.save

    @investment5 = Investment.new
    @investment5.investor_user_id = @investor.id
    @investment5.student_user_id = @student.id
    @investment5.amount = ""
    @investment5.save

  end


  def test_set_excessive_amount_errors_with_error
    @investment.initialize_errors_array
    @investment.set_excessive_amount_errors
    assert_includes(@investment.get_errors, "Amount exceeds debt amount")
    refute_empty @investment.get_errors
  end  

  def test_set_excessive_amount_errors_no_error
    @investment2.initialize_errors_array
    @investment2.set_excessive_amount_errors
    assert_empty @investment2.get_errors
  end

  def test_set_wrong_amount_errors
    @investment3.initialize_errors_array
    @investment3.set_wrong_amount_errors
    assert_includes(@investment3.get_errors, "Amount can't be 0")
    refute_empty @investment3.get_errors
  end

  def test_set_errors
    @investment.set_errors
    assert_includes(@investment.get_errors, "Amount exceeds debt amount")
  end

  def test_set_errors_wrong_amount
    @investment3.set_errors
    assert_includes(@investment3.get_errors, "Amount can't be 0")
  end

  def test_set_errors_blank_entry
    @investment4.set_errors
    @investment5.set_errors
    assert_includes(@investment4.get_errors, "Please enter a valid amount")
    assert_includes(@investment5.get_errors, "Please enter a valid amount")
  end

  def test_is_valid
    assert_equal(@investment.is_valid, false)
    assert_equal(@investment2.is_valid, true)
  end

end





