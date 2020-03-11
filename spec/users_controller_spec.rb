require 'spec_helper'

describe "UsersController" do
  describe "GET '/signup'" do
    it "shows signup form" do
      get '/signup'
      expect(last_response.body).to include("<h1>Create a New Account</h1>")
    end
  end

  describe "POST '/signup'" do
    it "can create new admin and company from form" do
      visit '/signup'

      fill_in :username, with: "SuperCleaner"
      fill_in :email, with: "cleanguy@cleaning.com"
      fill_in :password, with: "CleanGuy1"
      fill_in :passwordconfirm, with: "CleanGuy1"

      fill_in :company, with: "Super Cleanerzz"

      page.find(:css, "[type=submit]").click

      expect(Admin.last.username).to eq("SuperCleaner")
      expect(Company.last.name).to eq("Super Cleanerzz")
    end
  end

  describe "GET '/add_employee'" do
    before do
      @company = Company.create(name: "Super Cleanerzz")
      @admin = Admin.create(username: "SuperCleaner", email: "cleanguy@cleaning.com", password: "CleanGuy1", company_id: 1)
    end

    it "redirects to '/login' if not logged in" do
      get '/add_employee'
      follow_redirect!
      expect(last_request.path_info).to eq('/login')
      expect(last_response.body).to include("You must be logged in as an admin to create an employee account.")
    end

    it "displays form to create new employee account" do
      params = {
        username: "SuperCleaner",
        password: "CleanGuy1"
      }
      post '/login', params
      get '/add_employee'

      expect(last_response.body).to include("<h1>Add Employee to Your Company</h1>")
    end
  end

  describe "POST /add_employee" do
    before do
      @company = Company.create(name: "Super Cleanerzz")
      @admin = Admin.create(username: "SuperCleaner", email: "cleanguy@cleaning.com", password: "CleanGuy1", company_id: 1)
    end

    it "can create a new employee from the form" do
      login
      visit '/add_employee'

      fill_in :username, with: "ShinyFloorzz"
      fill_in :email, with: "floormaster@cleaner.com"
      fill_in :password, with: "sparkleSparkle1"
      fill_in :passwordconfirm, with: "sparkleSparkle1"

      page.find(:css, "[type=submit]").click

      expect(Employee.last.username).to eq("ShinyFloorzz")
    end
  end

  describe "GET '/employees'" do
    before do
      @company = Company.create(name: "Super Cleanerzz")
      @admin = Admin.create(username: "SuperCleaner", email: "cleanguy@cleaning.com", password: "CleanGuy1", company_id: 1)
      @employee = Employee.create(username: "ShinyFloorzz", email: "floormaster@cleaner.com", password: "sparkleSparkle1", company_id: 1)
      @employee = Employee.create(username: "DontShowMe!", email: "stayaway@ahh.com", password: "HideMe2", company_id: 3)
    end

    it "shows employees only if they are in the same company" do
      login
      visit '/employees'
      expect(page).to have_content("Username: ShinyFloorzz")
      expect(page).not_to have_content("Username: DontShowMe!")
    end
  end

  describe "DELETE '/employees/:id'" do
    before do
      @company = Company.create(name: "Super Cleanerzz")
      @admin = Admin.create(username: "SuperCleaner", email: "cleanguy@cleaning.com", password: "CleanGuy1", company_id: 1)
      @employee = Employee.create(username: "ShinyFloorzz", email: "floormaster@cleaner.com", password: "sparkleSparkle1", company_id: 1)
      @employee = Employee.create(username: "DontShowMe!", email: "stayaway@ahh.com", password: "HideMe2", company_id: 3)
    end

    it "deletes the correct employee" do
      delete '/employees/2'
      expect(Employee.all.size).to eq(1)
      expect(Employee.find_by(id: 2)).to eq(nil)
      expect(Employee.find(1).username).to eq("ShinyFloorzz")
    end
  end

  describe "GET '/login'" do
    it "displays login form" do
      get '/login'
      expect(last_response.body).to include("<h1>Login</h1>")
    end
  end

  describe "POST /login" do
    before do
      @company = Company.create(name: "Super Cleanerzz")
      @admin = Admin.create(username: "SuperCleaner", email: "cleanguy@cleaning.com", password: "CleanGuy1", company_id: 1)
      @employee = Employee.create(username: "ShinyFloorzz", email: "floormaster@cleaner.com", password: "sparkleSparkle1", company_id: 1)
    end

    it "sets session[:user_id] equal to id of the user" do
      params = {
        username: "SuperCleaner",
        password: "CleanGuy1"
      }
      post '/login', params
      follow_redirect!
      expect(session[:user_id]).to eq(1)
    end

    it "displays the correct username based on session[:user_id]" do
      params = {
        username: "ShinyFloorzz",
        password: "sparkleSparkle1"
      }
      post '/login', params
      follow_redirect!
      expect(last_response.body).to include('Welcome ShinyFloorzz!')
    end

    it "displays success flash message" do
      params = {
        username: "ShinyFloorzz",
        password: "sparkleSparkle1"
      }
      post '/login', params
      follow_redirect!
      expect(last_response.body).to include("You have successfully logged in.")
    end
  end

  describe "GET '/account'" do
    before do
      @company = Company.create(name: "Super Cleanerzz")
      @admin = Admin.create(username: "SuperCleaner", email: "cleanguy@cleaning.com", password: "CleanGuy1", company_id: 1)
      @employee = Employee.create(username: "ShinyFloorzz", email: "floormaster@cleaner.com", password: "sparkleSparkle1", company_id: 1)
    end

    it "displays correct username" do
      login
      expect(page).to have_content("Welcome SuperCleaner!")
    end

    it "displays links" do
      login
      expect(page).to have_content("View Inventory")
      expect(page).to have_content("Add Employee")
      expect(page).to have_content("View Employees")
      expect(page).to have_content("Log Out")
    end
  end

  describe "GET '/logout'" do
    before do
      @company = Company.create(name: "Super Cleanerzz")
      @admin = Admin.create(username: "SuperCleaner", email: "cleanguy@cleaning.com", password: "CleanGuy1", company_id: 1)
      @employee = Employee.create(username: "ShinyFloorzz", email: "floormaster@cleaner.com", password: "sparkleSparkle1", company_id: 1)
    end

    it "displays logged out flash" do
      login
      visit '/logout'
      expect(page).to have_content("You have successfully logged out.")
    end

    it "clears session hash" do
      params = {
        "username"=> "ShinyFloorzz", "password" => "sparkleSparkle1"
      }
      post '/login', params
      get '/logout'
      expect(session[:user_id]).to be(nil)
    end
  end
end
