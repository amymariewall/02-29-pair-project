# Investments controller actions go here


MyApp.before "/investments*" do
  @user = User.find_by_id(session["user_id"])
    if @user == nil
      redirect "/login"
    end
  end


MyApp.get "/investments/create" do
  @users_in_need = User.where.not({"debt_amount" => [0, nil]})
  erb :"investments/make_investment"
end

MyApp.get "/investments/invest/:user_id" do
  @user_in_need = User.find_by_id(params[:user_id])
  erb :"investments/invest"
end

MyApp.post "/investments/invest/make/:user_in_need_id" do 
  @investment = Investment.new(investor_user_id: session["user_id"], student_user_id: params[:user_in_need_id], amount: params["investment_amount"], paid: false)
  @user_in_need = User.find_by_id(params[:user_in_need_id])
  if @investment.is_valid == true
  @investment.save
  @user_in_need.debt_amount = (@user_in_need.debt_amount) - (@investment.amount)
  @user_in_need.save
  Pony.mail(:to => @investment.access_student.email, :from => 'do-not-reply', :subject => 'Pledge Alert!', :body => "#{@investment.access_investor.first_name} #{@investment.access_investor.last_name} sent you a pledge of $#{@investment.amount}")
  Pony.mail(:to => @investment.access_investor.email, :from => 'do-not-reply', :subject => 'Thanks for your pledge!', :body => "Thank you for pledging $#{@investment.amount} to #{@investment.access_student.first_name} #{@investment.access_student.last_name}. To make a payment, click here: https://www.dwolla.com/")
  redirect "/user/profile/#{@user_in_need.id}"
  elsif @investment.is_valid == false
    @errors = @investment.get_errors
    erb :"investments/invest"
  end
end

  
MyApp.post "/investments/:investment_id/update/paid" do 
  @investment = Investment.find_by_id(params[:investment_id])
    @investment.paid = true
    @investment.save
    @investment = Investment.find_by_id(params[:investment_id])
    Pony.mail(:to => @investment.access_investor.email, :from => 'do-not-reply', :subject => 'Payment Received', :body => 'Thanks, dude.')
    redirect "/user/profile/#{session["user_id"]}"
end







