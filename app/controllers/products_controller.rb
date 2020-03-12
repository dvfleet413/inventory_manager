class ProductsController < ApplicationController

  #Create
  get '/products/new' do
    @product = Product.new
    erb :'products/new'
  end

  post '/products' do
    @product = Product.create({name: params[:name],
                               price: params[:price].to_f,
                               quantity: params[:quantity],
                               company_id: current_user.company.id})
    redirect "/products/#{@product.id}"
  end

  #Read
  get '/products' do
    @company = current_user.company
    @products = current_user.products
    sql = <<-SQL
      SELECT SUM(products.price * products.quantity) FROM products
      WHERE products.company_id = #{@company.id}
    SQL
    @total = ActiveRecord::Base.connection.execute(sql)[0]['sum']
    erb :'products/index'
  end

  get '/products/:id' do
    @product = Product.find(params[:id])
    @product.company == current_user.company ? (erb :'products/show') : (redirect '/products')
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
