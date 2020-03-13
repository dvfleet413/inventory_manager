class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
    enable :static
    set :public_folder, 'public'
    register Sinatra::Flash
  end

  get '/' do
    erb :index
  end

  get '/help' do
    erb :help
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      if session[:role] == "admin"
        Admin.find(session[:user_id])
      elsif session[:role] == "employee"
        Employee.find(session[:user_id])
      else
        nil
      end
    end
  end

end
