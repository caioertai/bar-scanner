require 'nokogiri'
require 'open-uri'
require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

require_relative 'app/services/scrape'

# set :public_folder, 'app/public/'
set :views, (proc { File.join(root, "app/views") })
set :bind, '0.0.0.0'

get '/' do
  # @scrape = ScrapeService.search('shampoo liso absoluto fructis')
  erb :index
end
