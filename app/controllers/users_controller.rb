class EmployeesController < ApplicationController

  get '/signup' do
    erb :'registrations/signup'
  end

  post '/signup' do
    validate_username
    validate_company
    validate_password
    #Create new company and admin if above validations pass
    company = Company.create(name: params[:company][:name])
    user = Admin.new({
      username: params[:user][:username],
      email: params[:user][:email],
      password: params[:user][:password],
      company_id: company.id})
    if user.save
      redirect '/login'
    else
      flash[:alert_danger] = "Sorry, there was an error saving your account.  Please try again."
      redirect '/failure'
    end
  end

  get '/add_employee' do
    erb :'registrations/add_employee'
  end

  post '/add_employee' do
    validate_username
    validate_password
    user = Employee.new({
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

  get '/employees' do
    @users = Employee.select{|user| user.company == current_user.company}
    erb :'users/employees'
  end

  delete '/employees/:id' do
    @user = Employee.find(params[:id])
    @user.destroy
    redirect '/employees'
  end

  get '/login' do
    erb :'sessions/login'
  end

  post '/login' do
    admin = Admin.find_by(username: params[:username])
    employee = Employee.find_by(username: params[:username])
    #Username matches an Admin account
    if admin
      if admin.authenticate(params[:password])
        session[:user_id] = admin.id
        session[:company_id] = admin.company_id
        flash[:alert_success] = "You have successfully logged in."
        redirect '/account'
      else
        flash[:alert_danger] = "Incorrect password, please try again."
        redirect '/login'
      end
    #Username matches a User account
  elsif employee
      if employee.authenticate(params[:password])
        session[:user_id] = employee.id
        session[:company_id] = employee.company_id
        flash[:alert_success] = "You have successfully logged in."
        redirect '/account'
      else
        flash[:alert_danger] = "Incorrect password, please try again."
        redirect '/login'
      end
    #Username doesn't match any account
  elsif !admin && !employee
      flash[:alert_warning] = "Unable to find your account.  Please make sure you typed your username correctly."
      redirect '/login'
    else
      redirect '/failure'
    end
  end

  get '/account' do
    if current_user.admin?
      @user = Admin.find(session[:user_id])
    else
      @user = Employee.find(session[:user_id])
    end
    erb :'sessions/account'
  end

  get '/failure' do
    erb :'sessions/failure'
  end

  get '/logout' do
    session.clear
    flash[:alert_success] = "You have successfully logged out."
    redirect '/'
  end


  helpers do
    def validate_username
      #Make sure username is unique
      if Admin.all.collect{|admin| admin.username}.include?(params[:user][:username]) || Employee.all.collect{|employee| employee.username}.include?(params[:user][:username])
        flash[:alert_danger] = "The username #{params[:user][:username]} has already been taken."
        redirect '/signup'
      end
    end

    def validate_company
      #Make sure company is unique
      if Company.all.collect{|company| company.name}.include?(params[:company][:name])
        flash[:alert_danger] = "The company #{params[:company][:name]} has already been registered."
        redirect '/signup'
      end
    end

    def validate_password
      #Make sure password contains capital letter, lowercase letter, number, and is at least 6 chars long
      if !params[:user][:password].match(/(?=.*[a-z A-Z])(?=.*[1-9]).{6,}$/)
        flash[:alert_danger] = "Password must be at least 6 characters long and contain at least one uppercase letter, one lowercase letter, one number."
        redirect '/signup'
      #Make sure password and password_confirm match
      elsif params[:user][:password] != params[:user][:password_confirm]
        flash[:alert_danger] = "Passwords did not match, please try again."
        redirect '/signup'
      end
    end
  end

end
