class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
    enable :static
    set :public_folder, 'public' 
  end

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
