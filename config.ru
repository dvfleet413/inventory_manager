require 'sinatra/base'
require 'sinatra/flash'
require "./config/environment"
require_all './app'

use Rack::MethodOverride

use UsersController
use ProductsController
run ApplicationController
