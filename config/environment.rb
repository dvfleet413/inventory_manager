ENV['RACK_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

require 'sinatra/base'
require 'sinatra/flash'
require 'securerandom'
require 'require_all'
require 'pry'
require_all './app'
