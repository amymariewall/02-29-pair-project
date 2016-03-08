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
    @investment.amount = 500
    @investment.save

  end


  def test_set_excessive_amount_errors
    @errors = @investment.set_excessive_amount_errors

    assert_includes(@errors, "Amount exceeds debt amount")
    refute_includes(@errors, [])
  end  

  def test_set_blank_entry_errors
    refute_includes(@air_force_1.actors, @a2)
  end  

  def test_set_errors
  end


  def test_is_valid
  end

  def test_get_a_directors_movies
    assert_includes(@david_lean.movies, @m1)
    assert_includes(@david_lean.movies, @m2)
    assert_includes(@david_lean.movies, @m3)
    refute_includes(@david_lean.movies, @m4)
  end



end





