class UsersController < ApplicationController

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'registrations/signup'
  end

  post '/signup' do
    if Admin.all.collect{|admin| admin.username}.include?(params[:user][:username])
      redirect '/failure'
    elsif Company.all.collect{|company| company.name}.include?(params[:company][:name])
      redirect '/failure'
    elsif params[:user][:password] != params[:user][:password_confirm]
      redirect '/failure'
    else
      company = Company.create(name: params[:company][:name])
      user = Admin.new({
        username: params[:user][:username],
        email: params[:user][:email],
        password: params[:user][:password],
        company_id: company.id})
      if user.save
        redirect '/login'
      else
        redirect '/failure'
      end
    end
  end

  get '/add_employee' do
    erb :'registrations/add_employee'
  end

  post '/add_employee' do
    if User.all.collect{|user| user.username}.include?(params[:user][:username])
      redirect '/failure'
    else
      user = User.new({
        username: params[:user][:username],
        email: params[:user][:email],
        password: params[:user][:password],
        company_id: current_user.company.id})
      if user.save
        redirect '/account'
      else
        redirect '/failure'
      end
    end
  end

  get '/employees' do
    @users = User.select{|user| user.company == current_user.company}
    erb :'users/employees'
  end

  delete '/employees/:id' do
    @user = User.find(params[:id])
    @user.destroy
    redirect '/employees'
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

end
