# All Users controllers go here

MyApp.before "/user*" do
  @user = User.find_by_id(session["user_id"])
    if @user == nil
      session["path_info"] = request.path_info
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
    # at this point @user.active == nil
    if !@user.active 
      @user.confirm_token = SecureRandom.urlsafe_base64.to_s
      @user.save
      Pony.mail(:to => @user.email, :from => 'do-not-reply', :subject => 'Confirm your StuLo account', :body => "Welcome to StuLo #{@user.first_name} #{@user.last_name}! Please confirm your account at this link: http://localhost:9292/confirm/#{@user.confirm_token}")
      @activation_message = "Thanks for registering! Please check your email to confirm your account."
    end

    erb :"main/homepage"
    # Redirecting to "/" would be better. Figure out how to pass @activation_message to that action.

  else 
    @errors = @user.get_errors
    erb :"users/create"
  end
end

MyApp.get "/confirm/:confirm_token" do
  @user = User.find_by_confirm_token(params[:confirm_token])
  if @user
    @user.active = true
    @user.confirm_token = nil
    @user.save
    redirect "/login"
  else
    redirect "/signup"
  end
end

MyApp.get "/user/profile/:user_id" do
  session["path_info"] = nil
  @user = User.find_by_id(params[:user_id]) 
  @user_presenter = UserPresenter.new(@user)
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

MyApp.get "/search/user" do 
  erb :"users/search"
end

MyApp.post "/search/user/process" do 
  search_hash = {}
  search_hash[params["search_criteria"]] = params["search_term"]
  @search_results = User.where(search_hash)
  if @search_results == []
    @error = "No user found for that search. Search again."
    erb :"users/search"
  else
  erb :"users/search_results"
  end
end











