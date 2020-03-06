require "./config/environment"
require_all './app'

use Rack::MethodOverride

use EmployeesController
use ProductsController
run ApplicationController
