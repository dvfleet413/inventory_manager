# Inventory Manager

Inventory manager is a CRUD web app designed to help small service businesses manage their inventory of supplies
and equipment. Each Company has one Admin, has many Users, and has many Products. Admins are able to create new
Products, read Products, update the name, price, and quantity of Products, and delete Products.  Users are able to read Products and update the quantity of Products.  

New Users must be created by Admins. New Admins can signup at GET '/signup', and will create a new Company with the same form.  

## Installation Instructions

Fork and clone this repository. Run `bundle install` in the project directory.  Run `rake db:migrate` to set up database (requires PostgreSQL). To run the app locally, run `shotgun` and navigate to localhost as directed.  

## Contributor's Guide

Bug reports and Pull Requests are welcomed on GitHub at [github.com/dvfleet413/inventory_manager](github.com/dvfleet413/inventory_manager).  

## License

View MIT License [here](https://github.com/dvfleet413/inventory_manager/blob/master/LICENSE.md).
