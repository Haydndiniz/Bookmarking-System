require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
# require 'erb'
require_relative 'app/main.rb'

puts "#{Socket.gethostname}"

set :bind, '0.0.0.0' # Needed when running from Codio
include ERB::Util #Ensure ERB is enabled

configure do
	enable :sessions
    $db = SQLite3::Database.open 'database.db'  
end
