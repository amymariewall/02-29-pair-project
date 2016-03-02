MyApp.post "/status/create" do
  @update = Update.new
  @update.status_update = params[:status_update]
  @update.user_id = session["user_id"]
  @update.save
  redirect "/user/profile"
end

