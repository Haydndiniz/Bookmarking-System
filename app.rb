require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'bcrypt'
require 'sinatra/flash'

require_relative 'app/main.rb'
require_relative 'app/login.rb'
require_relative 'app/new_bookmark.rb'
require_relative 'app/new_feedback.rb'
require_relative 'app/edit_bookmark.rb'
require_relative 'app/admin.rb'


require_relative 'models/user.rb'
require_relative 'models/bookmarks.rb'
require_relative 'models/feedback.rb'

puts "#{Socket.gethostname}"

set :bind, '0.0.0.0' # Needed when running from Codio
include ERB::Util #Ensure ERB is enabled

configure do
	enable :sessions
    set :session_secret, 'super secret' 
    DATABASE = './database/acme_db.sqlite'
    $db = SQLite3::Database.new DATABASE
end
