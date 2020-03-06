class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']{ SecureRandom.hex(64) }
    enable :static
    set :public_folder, 'public'
    register Sinatra::Flash
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      if Admin.find(session[:user_id])
        return Admin.find(session[:user_id])
      else
        Employee.find(session[:user_id])
      end
    end
  end

end
