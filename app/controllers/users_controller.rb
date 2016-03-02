# All Users controllers go here

MyApp.before "/user*" do
  @user = User.find_by_id(session["user_id"])
    if @user == nil
      redirect "/login"
    end
  end

MyApp.get "/signup" do 
  erb :"users/create"
end

MyApp.post "/create/user" do
  @user = User.new
  @user.first_name = params["first_name"]
  @user.last_name = params["last_name"]
  @user.email = params["email"]
  @user.password = params["password"]
  @user.debt_amount = params["debt_amount"]
  @user.save
  erb :"users/user_created"
end

MyApp.get "/user/profile/:user_id" do
  @user = User.find_by_id(params[:user_id]) 
  @investments = Investment.where({"investor_user_id" => @user.id})
  @donations_received = Investment.where({"student_user_id" => @user.id})
  erb :"users/user_profile"
end

MyApp.get "/user/list" do
  @users = User.all
  erb :"/users/users_list"
end

MyApp.get "/user/update" do
  @user = User.find_by_id(session["user_id"])
  erb :"/users/update_user"
end

MyApp.post "/user/process/update" do
  @user = User.find_by_id(session["user_id"])
  @user.first_name = params["first_name"]
  @user.last_name = params["last_name"]
  @user.email = params["email"]
  @user.password = params["password"]
  @user.debt_amount = params["debt_amount"]
  @user.save
  redirect "/user/profile/#{@user.id}"
end

MyApp.post "/user/delete" do
  @user = User.find_by_id(session["user_id"])
  @user.delete
  redirect "/logout"
end


MyApp.get "/user/profile" do
  @user = User.find_by_id(session["user_id"])   
  redirect "/user/profile/#{@user.id}"
end
















