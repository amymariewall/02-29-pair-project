# Investments controller actions go here

MyApp.get "/investments/create" do
  @users_in_need = User.where.not({"debt_amount" => [0, nil]})
  erb :"investments/make_investment"
end

MyApp.get "/investments/invest/:user_id" do
  @user_in_need = User.find_by_id(params[:user_id])
  erb :"investments/invest"
end

MyApp.post "/investments/invest/make/:user_in_need_id" do 
  @investment = Investment.new(investor_user_id: session["user_id"], student_user_id: params[:user_in_need_id], amount: params["investment_amount"])
  @investment.save
  @user_in_need = User.find_by_id(params[:user_in_need_id])
  @user_in_need.debt_amount = (@user_in_need.debt_amount) - (@investment.amount)
  @user_in_need.save
  redirect "/user/profile/#{@user_in_need.id}"
  #erb :"investments/successful_investment"
end