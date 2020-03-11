require 'spec_helper'

describe "ProductsController" do
  describe "GET '/products/new'" do
    it "displays New Product form" do
      get '/products/new'
      expect(last_response.body).to include("Create New Product")
    end
  end

  describe "POST '/products'" do
    before do
      @company = Company.create(name: "Super Cleanerzz")
      @admin = Admin.create(username: "SuperCleaner", email: "cleanguy@cleaning.com", password: "CleanGuy1", company_id: 1)
    end
    it "can create new product from form" do
      login
      visit '/products/new'

      fill_in :name, with: "Orange Blossom"
      fill_in :price, with: "10.99"
      fill_in :quantity, with: "4"

      page.find(:css, "[type=submit]").click

      expect(Product.last.name).to eq("Orange Blossom")
    end

    it "redirects to show new product" do
      login
      visit '/products/new'

      fill_in :name, with: "Orange Blossom"
      fill_in :price, with: "10.99"
      fill_in :quantity, with: "4"

      page.find(:css, "[type=submit]").click
      
      expect(page).to have_content("Orange Blossom")
      expect(page).to have_content("$10.99")
      expect(page).to have_content("4")
    end
  end




end
