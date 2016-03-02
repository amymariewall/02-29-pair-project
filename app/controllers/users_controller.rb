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
  if @user.is_valid == true
    @user.save
    redirect "/login"
  else 
    @errors = @user.get_errors
    erb :"users/create"
  end
end

MyApp.get "/user/profile/:user_id" do
  @user = User.find_by_id(params[:user_id]) 
  @investments = Investment.where({"investor_user_id" => @user.id})
  @donations_received = Investment.where({"student_user_id" => @user.id})
  @status_updates = Update.where({"user_id" => @user.id})
  @status_updates_time = @status_updates.order(created_at: :desc)
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
  if @user.is_valid == true
    @user.save
    redirect "/user/profile/#{@user.id}"
  else 
    @errors = @user.get_errors
    erb :"/users/update_user"
  end
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





