require 'sinatra/base'

require './app/controllers/application_controller'
require './app/controllers/users_controller'
require './app/controllers/products_controller'

use Rack::MethodOverride

use UsersController
use ProductsController
run ApplicationController
