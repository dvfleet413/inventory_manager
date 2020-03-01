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
                               user_id: session[:user_id]})
    redirect "/products/#{@product.id}"
  end


  #Read
  get '/products' do
    @products = Product.all.select{|product| product.user_id == session[:user_id]}
    sql = <<-SQL
      SELECT SUM(products.price * products.quantity) FROM products
      WHERE products.user_id = #{session[:user_id]}
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






end
