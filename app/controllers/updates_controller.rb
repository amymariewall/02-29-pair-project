
MyApp.before "/update*" do
  @user = User.find_by_id(session["user_id"])
    if @user == nil
      redirect "/login"
    end
  end


MyApp.post "/update/create" do
  @update = Update.new
  @update.status_update = params[:status_update]
  @update.user_id = session["user_id"]
  @update.save
  redirect "/user/profile"
end

MyApp.post "/update/edit/:update_id" do
  @update = Update.find_by_id(params[:update_id])
  erb :"/updates/edit"
end

MyApp.post "/update/process/:update_id" do
  @update = Update.find_by_id(params[:update_id])
  @update.status_update = params[:status]
  @update.save
  redirect "/user/profile"
end
MyApp.post "/update/delete/:update_id" do
  @update = Update.find_by_id(params[:update_id])
  @update.delete
  redirect "/user/profile"
end