require 'sinatra/reloader' if development?
require 'sinatra/cookies'

# load models
require "./models/models.rb"
require "./models/user.rb"
require "./models/post.rb"
require "./models/language.rb"
require "./models/like.rb"
require "./models/follow.rb"

# load modules
require "sass"
require "pry"

# configs
enable :sessions
set :sass, {:style => :compact }

# load helpers
require "./appHelpers"