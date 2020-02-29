require 'sinatra/base'

require './app/controllers/application_controller'
require './app/controllers/users_controller'


use UsersController
run ApplicationController
