require "./config/environment"
require "./app/models/product"
require 'pry'

class ProductsController < Sinatra::Base
  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  #Create
  get '/products/new' do
    @product = Product.new
    erb :'products/new'
  end

  post '/products' do
    @product = Product.create({name: params[:name],
                               price: params[:price].to_f,
                               quantity: params[:quantity],
                               company_id: session[:company_id]})
    redirect "/products/#{@product.id}"
  end

  #Read
  get '/products' do
    @company = Company.find(session[:company_id])
    @products = Product.all.select{|product| product.company_id == session[:company_id]}
    sql = <<-SQL
      SELECT SUM(products.price * products.quantity) FROM products
      WHERE products.company_id = #{session[:company_id]}
    SQL
    @total = ActiveRecord::Base.connection.execute(sql)[0]['sum']
    erb :'products/index'
  end

  get '/products/:id' do
    @product = Product.find(params[:id])
    erb :'products/show'
  end

  #Update
  get '/products/:id/edit' do
    @product = Product.find(params[:id])
    erb :'products/edit'
  end

  patch '/products/:id' do
    @product = Product.find(params[:id])
    @product.name = params[:name]
    @product.price= params[:price]
    @product.quantity = params[:quantity]
    @product.save
    redirect "/products/#{@product.id}"
  end

  #Delete
  delete '/products/:id' do
    @product = Product.find(params[:id])
    @product.destroy
    redirect '/products'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def admin?
      session[:role] == "admin"
    end
  end

end
