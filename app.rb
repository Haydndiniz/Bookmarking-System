require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

require_relative 'app/main.rb'
require_relative 'app/login.rb'

require_relative 'models/user.rb'
require_relative 'models/bookmarks.rb'




puts "#{Socket.gethostname}"

set :bind, '0.0.0.0' # Needed when running from Codio
include ERB::Util #Ensure ERB is enabled

configure do
	enable :sessions
    set :session_secret, 'super secret'
    $db = SQLite3::Database.new 'database.sql'  
end
