MyApp.post "/status/create" do
  @update = Update.new
  @update.status_update = params[:status_update]
  @update.user_id = session["user_id"]
  @update.save
  redirect "/user/profile"
end

MyApp.get "/update/edit/:update_id" do
  @update = Update.find_by_id(params[:update_id])
  erb :"/updates/edit"
end

MyApp.post "/update/process/:update_id" do
  @update = Update.find_by_id(params[:update_id])
  @update.status_update = params[:status]
  @update.save
  redirect "/user/profile"
end
MyApp.post "/update/delete" do
  
end