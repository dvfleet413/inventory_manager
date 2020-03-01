require "./config/environment"
require "./app/models/product"

class ProductsController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  #Create
  get '/products/new' do

  end

  post '/products' do

  end


  #Read
  get '/products' do
    erb :'products/index'
  end

  get '/products/:id' do

  end


  #Update
  get '/products/:id/edit' do

  end

  patch '/products/:id' do

  end


  #Delete
  delete '/products/:id' do

  end






end
