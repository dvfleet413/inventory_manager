class ProductsController < ApplicationController

  #Create
  get '/products/new' do
    redirect_if_not_logged_in
    @product = Product.new
    erb :'products/new'
  end

  post '/products' do
    @product = current_user.company.products.create(params)
    redirect "/products/#{@product.id}"
  end

  #Read
  get '/products' do
    redirect_if_not_logged_in
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
    redirect_if_not_logged_in
    set_product
    @product.company == current_user.company ? (erb :'products/show') : (redirect '/products')
  end

  #Update
  get '/products/:id/edit' do
    redirect_if_not_logged_in
    set_product
    @product.company == current_user.company ? (erb :'products/edit') : (redirect '/products')
  end

  patch '/products/:id' do
    set_product
    if @product && is_authorized
      @product.update({
        name: params[:name],
        price: params[:price],
        quantity: params[:quantity]})
    end
    redirect "/products/#{@product.id}"
  end

  #Delete
  delete '/products/:id' do
    set_product
    @product.destroy if is_authorized
    redirect '/products'
  end

  private
    def set_product
      @product = Product.find_by_id(params[:id])
    end

    def is_authorized
      @product.company == current_user.company
    end


end
