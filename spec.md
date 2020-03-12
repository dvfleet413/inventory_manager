# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
- [x] Include more than one model class (e.g. User, Post, Category)  
  - Product model (products in inventory )
  - Company model  
  - Two types of User models:
    - Admin model (can create new products and existing products in the company's inventory)  
    - Employee model (can update the quantity of products in their company's inventory)
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)  
  - Company has_many Products
  - Two types of User models:
    - Admin has_many Products through Company  
    - Employee has_many Products through Company
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
  - Products belong_to Company
  - Admin belongs_to Company
  - Employee belongs_to Company
- [x] Include user accounts with unique login attribute (username or email)
  - Upon account creation, username is validated as unique (email can be reused)
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying  
  - Products can be Created (by Admin), Read (by Admins or Employees), Updated (all attributes by Admin, quantity by Employee), and Deleted (by Admin)
- [ ] Ensure that users can't modify content created by other users
- [x] Include user input validations  
  - For Product:  
    - Create and Update actions are validated by form input types ('text' for product[name], 'number' with step '0.01' for product[price] and 'number' for product[quantity]) in view
  - For new users:  
    - username, password, and company name are validated in helper methods in UsersController
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
  - used sinatra flash gem and Bootstrap to display flash messages
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [ ] You have a large number of small Git commits
- [ ] Your commit messages are meaningful
- [ ] You made the changes in a commit that relate to the commit message
- [ ] You don't include changes in a commit that aren't related to the commit message
