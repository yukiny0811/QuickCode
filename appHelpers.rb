helpers do
  
  def is_user_logged_in
    if session[:user]
      return true
    else 
      return false
    end
  end
  
  def current_user 
    if session[:user]
      return User.find_by(id: session[:user])
    end
  end
  
  def current_user_id
    if session[:user]
      return session[:user]
    end
  end
  
  def convert_image_source(img)
    base64 = Base64.encode64(img).gsub(/\n/, "") +  "\n"
    return "data:"+ "image/png" + ";base64," + base64
  end
  
  def like_bg_color(isLiked)
    if isLiked
      return "rgb(239, 71, 111)"
    else 
      return "white"
    end
  end
  
  def like_tx_color(isLiked)
    if isLiked
      return "white"
    else 
      return "rgb(239, 71, 111)"
    end
  end
  
  def following_bg_color(isLiked)
    if isLiked
      return "rgb(239, 71, 111)"
    else 
      return "white"
    end
  end
  
  def following_tx_color(isLiked)
    if isLiked
      return "white"
    else 
      return "rgb(239, 71, 111)"
    end
  end
  
end