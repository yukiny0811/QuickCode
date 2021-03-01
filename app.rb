require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'sinatra/cookies'
require "./models/models.rb"
require "./models/user.rb"
require "./models/post.rb"
require "./models/language.rb"
require "sass"

enable :sessions

set :sass, {:style => :compact }

helpers do
  
  def is_user_logged_in
    if session[:user]
      return true
    else 
      return false
    end
  end
  
  def user_session_check
    if not session[:user]
      redirect "/"
    end
  end
  
  def current_user 
    if session[:user]
      return User.find_by(id: session[:user])
    end
  end
  
  def convert_image_source(img)
    base64 = Base64.encode64(img).gsub(/\n/, "") +  "\n"
    return "data:"+ "image/png" + ";base64," + base64
  end
  
end

not_found do
  redirect "/"
end

# get requests -------

# main page
get "/" do
  @posts = Post.order(id: :DESC)
  slim :index
end

# signup page
get "/signup" do
  if not is_user_logged_in
    slim :signup
  else 
    redirect "/"
  end
end

# login page 
get "/login" do
  if not is_user_logged_in
    slim :login
  else 
    redirect "/"
  end
end

get "/:username" do
  @user = User.find_by(name: params[:username])
  if not @user 
    redirect "/"
  end
  slim :userpage
end

# new post 
get "/:username/post/new" do
  user_session_check
  slim :newpost
end

# post requests -------

# signup
post "/signup" do
  if is_user_logged_in
    redirect "/"
  end
  if not params[:username]
    redirect "/"
  end
  if not params[:password]
    redirect "/"
  end
  if not params[:password_confirmation]
    redirect "/"
  end
  user = User.create(
    name: params[:username],
    password: params[:password],
    password_confirmation: params[:password_confirmation]
  )
  session[:user] = user.id
  redirect "/"
end

# logout
post "/logout" do
  session[:user] = nil
  redirect "/"
end

# login 
post "/login" do
  if is_user_logged_in
    redirect "/"
  end
  if not params[:username]
    redirect "/"
  end
  if not params[:password]
    redirect "/"
  end
  user = User.find_by(name: params[:username])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect "/"
end

post "/:username/post/new" do
  if Language.find_by(language: params[:language]).nil?
    Language.create(
      language: params[:language]
    )
  end
  Post.create(
    user_id: current_user.id,
    content: params[:content],
    description: params[:description],
    output_type: params[:outputs],
    language_id: Language.find_by(language: params[:language]).id,
    language_version: params[:language_version],
    framework: params[:framework],
    title: params[:title],
    inputs: params[:inputs]
  )
  redirect "/"
end

post "/search" do
  key = params[:searchKey]
  if params[:search_title] == "title"
    if params[:search_language] == "language"
      if params[:search_framework] == "framework"
        if params[:search_description] == "description"
          @posts = Post.all.where("title LIKE :args1 OR language LIKE :args2 OR framework LIKE :args3 OR description LIKE :args4", args1: "%#{key}%", args2: "%#{key}%", args3: "%#{key}%", args4: "%#{key}%").all
        else 
          @posts = Post.all.where("title LIKE :args1 OR language LIKE :args2 OR framework LIKE :args3", args1: "%#{key}%", args2: "%#{key}%", args3: "%#{key}%").all
        end
      else 
        @posts = Post.all.where("title LIKE :args1 OR language LIKE :args2", args1: "%#{key}%", args2: "%#{key}%").all
      end
    else 
      @posts = Post.all.where("title LIKE :args1", args1: "%#{key}%").all
    end
  else 
    @posts = Post.none
  end
  # todo ここをなんとかする
  @posts = @posts.order(id: :DESC)
  slim :index
end

# sass -------

get "/sass/base.css" do
  sass :'sass/base'
end

get "/sass/signup.css" do
  sass :'sass/signup'
end

get "/sass/login.css" do
  sass :'sass/login'
end

get "/sass/userpage.css" do
  sass :'sass/userpage'
end

get "/sass/newpost.css" do
  sass :'sass/newpost'
end

get "/sass/index.css" do
  sass :'sass/index'
end