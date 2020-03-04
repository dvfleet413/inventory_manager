class UsersController < ApplicationController

#  configure do
#    set :views, "app/views"
#    enable :sessions
#    set :session_secret, "password_security"
#  end

  get '/' do
    erb :index
  end

  get '/signup' do
    @companies = Company.all
    erb :'registrations/signup'
  end

  post '/signup' do
    if Company.all.collect{|company| company.id}.include?(params[:user][:company_id].to_i)
      user = User.new({
        username: params[:user][:username],
        email: params[:user][:email],
        password: params[:user][:password],
        company_id: params[:user][:company_id]})
    else
      company = Company.create(name: params[:company][:name])
      user = Admin.new({
        username: params[:user][:username],
        email: params[:user][:email],
        password: params[:user][:password],
        company_id: company.id})
    end
    if user.save
      redirect '/login'
    else
      redirect '/failure'
    end
  end

  get '/login' do
    erb :'sessions/login'
  end

  post '/login' do
    admin = Admin.find_by(username: params[:username])
    user = User.find_by(username: params[:username])
    if admin && admin.authenticate(params[:password])
      session[:user_id] = admin.id
      session[:company_id] = admin.company_id
      session[:role] = "admin"
      redirect '/account'
    elsif user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:company_id] = user.company_id
      redirect '/account'
    else
      redirect '/failure'
    end
  end

  get '/account' do
    if admin?
      @user = Admin.find(session[:user_id])
    else
      @user = User.find(session[:user_id])
    end
    erb :'sessions/account'
  end

  get '/failure' do
    erb :'sessions/failure'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

#  helpers do
#    def logged_in?
#      !!session[:user_id]
#    end
#
#    def current_user
#      User.find(session[:user_id])
#    end
#
#    def admin?
#      session[:role] == "admin"
#    end
#  end

end
