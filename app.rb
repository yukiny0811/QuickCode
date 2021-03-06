require "./appRequires"

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
  if is_user_logged_in
    redirect "/"
  else 
    slim :signup
  end
end

# login page 
get "/login" do
  if is_user_logged_in
    redirect "/"
  else 
    slim :login
  end
end

# userpage
get "/:username" do
  @user = User.find_by(name: params[:username])
  if not @user 
    redirect "/"
  end
  slim :userpage
end

# new post 
get "/:username/post/new" do
  if is_user_logged_in
    slim :newpost
  else
    redirect "/"
  end
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
  if not current_user
    return
  end
  if Language.find_by(language: params[:language]).nil?
    Language.create(
      language: params[:language]
    )
  end
  Post.create(
    user_id: current_user_id,
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
  keys = key.split(/[[:blank:]]+/)
  
  @posts = Post.all
  logger.info keys
  keys.each do |k|
    if params[:search_option].count == 4
      @posts = @posts.where("#{params[:search_option][0]} LIKE '%#{k}%' OR #{params[:search_option][1]} LIKE '%#{k}%' OR #{params[:search_option][2]} LIKE '%#{k}%' OR #{params[:search_option][3]} LIKE '%#{k}%'").all
    elsif params[:search_option].count == 3
      @posts = @posts.where("#{params[:search_option][0]} LIKE '%#{k}%' OR #{params[:search_option][1]} LIKE '%#{k}%' OR #{params[:search_option][2]} LIKE '%#{k}%'").all
    elsif params[:search_option].count == 2
      @posts = @posts.where("#{params[:search_option][0]} LIKE '%#{k}%' OR #{params[:search_option][1]} LIKE '%#{k}%'").all
    elsif params[:search_option].count == 1
      @posts = @posts.where("#{params[:search_option][0]} LIKE '%#{k}%'").all
    else 
      @posts = Post.none
    end
  end
  @posts = @posts.order(id: :DESC)
  slim :searchResult
end

post "/like/:post_id" do
  if Like.find_by(user_id: session[:user], post_id: params[:post_id]).present?
    Like.find_by(user_id: session[:user], post_id: params[:post_id]).destroy
    return false
  else
    Like.create(
      user_id: session[:user],
      post_id: params[:post_id]
    )
    return true
  end
end

post "/follow/:to_user_id" do
  if Follow.find_by(follow_from: session[:user], follow_to: params[:to_user_id]).present?
    Follow.find_by(follow_from: session[:user], follow_to: params[:to_user_id]).destroy
    return false
  else
    Follow.create(
      follow_from: session[:user],
      follow_to: params[:to_user_id]
    )
    return true
  end
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

get "/sass/searchResult.css" do
  sass :'sass/searchResult'
end

get "/sass/post.css" do
  sass :'sass/post'
end
