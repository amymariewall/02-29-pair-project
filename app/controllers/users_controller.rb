# All Users controllers go here

MyApp.get "/signup" do 
  erb :"users/create"
end

MyApp.post "/users/process/create" do
  @user = User.new
  @user.first_name = params["first_name"]
  @user.last_name = params["last_name"]
  @user.email = params["email"]
  @user.password = params["password"]
  @user.debt_amount = params["debt_amount"]
  @user.save
  erb :"users/user_created"
end