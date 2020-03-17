require 'spec_helper'

describe "ProductsController" do
  describe "Create" do
    describe "GET '/products/new'" do
      before do
        @company = Company.create(name: "Super Cleanerzz")
        @admin = Admin.create(username: "SuperCleaner", email: "cleanguy@cleaning.com", password: "CleanGuy1", company_id: 1)
      end
      it "displays New Product form" do
        login
        visit '/products/new'
        expect(page).to have_content("Create New Product")
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

  describe "Read" do
    describe "GET '/products'" do
      before do
        Company.create(name: "Super Cleanerz")
        Admin.create(username: "SuperCleaner", email: "cleanguy@cleaning.com", password: "CleanGuy1", company_id: 1)
        Product.create(name: "Orange Blossom", price: "10.99", quantity: "6", company_id: 1)
        Product.create(name: "Perox-a-Peel", price: "11.50", quantity: "3", company_id: 1)
        Product.create(name: "Spray Away", price: "13.00", quantity: "4", company_id: 1)
        Product.create(name: "Creme Cote", price: "15.99", quantity: "1", company_id: 1)
        Product.create(name: "Paneless", price: "14.00", quantity: "3", company_id: 1)
        Product.create(name: "Don't Show Me!", price: "14.00", quantity: "3", company_id: 2)
      end

      it "shows all the products in the user's company" do
        login
        visit '/products'
        expect(page).to have_content("Orange Blossom")
      end

      it "doesn't show products that belong to another company" do
        login
        visit '/products'
        expect(page).not_to have_content("Don't Show Me!")
      end
    end

    describe "GET '/products/:id'" do
      before do
        Company.create(name: "Super Cleanerz")
        Admin.create(username: "SuperCleaner", email: "cleanguy@cleaning.com", password: "CleanGuy1", company_id: 1)
        Product.create(name: "Orange Blossom", price: "10.99", quantity: "6", company_id: 1)
        Product.create(name: "Perox-a-Peel", price: "11.50", quantity: "3", company_id: 1)
        Product.create(name: "Spray Away", price: "13.00", quantity: "4", company_id: 1)
        Product.create(name: "Creme Cote", price: "15.99", quantity: "1", company_id: 1)
        Product.create(name: "Paneless", price: "14.00", quantity: "3", company_id: 1)
        Product.create(name: "Don't Show Me!", price: "14.00", quantity: "3", company_id: 2)
      end

      it "displays the correct product information" do
        login
        visit '/products/1'
        expect(page).to have_content("Orange Blossom")
        expect(page).to have_content("$10.99")
        expect(page).to have_content("6")
      end

      it "redirects to '/products' if product doesnt belong to user" do
        login
        visit '/products/6'
        expect(page).to have_current_path('/products')
      end
    end
  end

  describe "Update" do
    describe "GET '/products/:id/edit'" do
      before do
        Company.create(name: "Super Cleanerz")
        Admin.create(username: "SuperCleaner", email: "cleanguy@cleaning.com", password: "CleanGuy1", company_id: 1)
        Product.create(name: "Orange Blossom", price: "10.99", quantity: "6", company_id: 1)
        Product.create(name: "Perox-a-Peel", price: "11.50", quantity: "3", company_id: 1)
        Product.create(name: "Spray Away", price: "13.00", quantity: "4", company_id: 1)
        Product.create(name: "Creme Cote", price: "15.99", quantity: "1", company_id: 1)
        Product.create(name: "Paneless", price: "14.00", quantity: "3", company_id: 1)
        Product.create(name: "Don't Show Me!", price: "14.00", quantity: "3", company_id: 2)
      end

      it "displays the correct product to edit" do
        login
        visit '/products/1/edit'
        expect(page).to have_content("Edit Product")
        expect(find_field('name').value).to eq("Orange Blossom")
        expect(find_field('price').value).to eq("10.99")
        expect(find_field('quantity').value).to eq("6")
      end

      it "redirects to '/products' if product doesnt belong to user" do
        login
        visit '/products/6/edit'
        expect(page).to have_current_path('/products')
      end
    end

    describe "PATCH '/products/:id'" do
      before do
        Company.create(name: "Super Cleanerz")
        Admin.create(username: "SuperCleaner", email: "cleanguy@cleaning.com", password: "CleanGuy1", company_id: 1)
        Product.create(name: "Orange Blossom", price: "10.99", quantity: "6", company_id: 1)
        Product.create(name: "Perox-a-Peel", price: "11.50", quantity: "3", company_id: 1)
        Product.create(name: "Spray Away", price: "13.00", quantity: "4", company_id: 1)
        Product.create(name: "Creme Cote", price: "15.99", quantity: "1", company_id: 1)
        Product.create(name: "Paneless", price: "14.00", quantity: "3", company_id: 1)
        Product.create(name: "Don't Show Me!", price: "14.00", quantity: "3", company_id: 2)
      end

      it "updates product record" do
        login
        visit '/products/1/edit'

        fill_in :name, with: "Oranger Blossom"
        fill_in :price, with: "9.99"
        fill_in :quantity, with: "1000"

        page.find(:css, "[type=submit]").click

        expect(Product.find(1).name).to eq("Oranger Blossom")
        expect(Product.find(1).price).to eq(9.99)
        expect(Product.find(1).quantity).to eq(1000)
      end
    end
  end

  describe "Destroy" do
    describe "DELETE '/product/:id'" do
      before do
        Company.create(name: "Super Cleanerz")
        Admin.create(username: "SuperCleaner", email: "cleanguy@cleaning.com", password: "CleanGuy1", company_id: 1)
        Product.create(name: "Orange Blossom", price: "10.99", quantity: "6", company_id: 1)
        Product.create(name: "Perox-a-Peel", price: "11.50", quantity: "3", company_id: 1)
        Product.create(name: "Spray Away", price: "13.00", quantity: "4", company_id: 1)
        Product.create(name: "Creme Cote", price: "15.99", quantity: "1", company_id: 1)
        Product.create(name: "Paneless", price: "14.00", quantity: "3", company_id: 1)
        Product.create(name: "Don't Show Me!", price: "14.00", quantity: "3", company_id: 2)
      end

      it "deletes product record" do
        login
        delete '/products/1'
        expect(Product.find_by(id: 1)).to eq(nil)
      end
    end
  end

end
