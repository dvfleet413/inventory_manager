require 'pry'

class UsersController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'registrations/signup'
  end

  post '/signup' do
    user = User.new({
      username: params[:username],
      email: params[:email],
      password: params[:password]})
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
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/account'
    else
      redirect '/failure'
    end
  end

  get '/account' do
    @user = User.find(params[:user_id])
    erb :account
  end

  get '/failure' do

  end

  get '/logout' do
    session.clear
    redirect '/'
  end





end
