require 'sinatra'
require_relative 'cvv.rb'

run Rack::URLMap.new('/api' => Api)

configure do
  set :server, :puma
  set :root, File.dirname(__FILE__)
  enable :static
  enable :dump_errors
  set :show_exceptions, false # uncomment for testing or production
end
