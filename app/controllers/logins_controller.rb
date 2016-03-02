# Login controllers go here!

MyApp.get "/login" do 
  erb :"logins/login"
end

MyApp.post "/login/create" do 
  @user = User.find_by_email(params[:email])
  if @user != nil && @user.password == params[:password]
      session["user_id"] = @user.id    
      redirect "/user/profile/#{@user.id}"
    else
      redirect "/login"
  end
end

MyApp.get "/logout" do 
  session["user_id"] = nil
  redirect "/"
end