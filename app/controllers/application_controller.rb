class ApplicationController < Sinatra::Base

  set :views, "app/views"
  set :public_folder, File.join(root, "public")
  enable :sessions
  set :session_secret, "password_security"

  get '/' do
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def admin?
      session[:role] == "admin"
    end

    def current_user
      admin? ? Admin.find(session[:user_id]) : User.find(session[:user_id])
    end
  end

end
