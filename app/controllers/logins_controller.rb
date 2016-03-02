# Login controllers go here!

MyApp.get "/login" do 
  erb :"logins/login"
end

MyApp.post "/login/create" do 
  @user = User.find_by_email(params[:email])
    if @user != nil && @user.password == params[:password]
      session["user_id"] = @user.id    
      redirect "/user/profile/#{@user.id}"
    elsif @user != nil && @user.password != params[:password]
      @error = "Invalid password."
      erb :"logins/login"
    elsif @user == nil
      @error = "No user for that email address."  
      erb :"logins/login"
    end
end

MyApp.get "/logout" do 
  session["user_id"] = nil
  redirect "/"
end