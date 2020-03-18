require 'sinatra'
require 'sinatra/reloader'

set :bind, '0.0.0.0' # Needed when running from Codio
include ERB::Util #Ensure ERB is enabled

configure do
	enable :sessions
    $db = SQLite3::Database.new 'database.db'  
end