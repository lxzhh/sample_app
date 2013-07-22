module SessionsHelper
  def sign_in(user)
      puts "sign_in "
      cookies.permanent[:remember_token] = user.remember_token
      self.current_user = user
  end
    
  def sign_out
      self.current_user = nil
      cookies.delete(:remember_token)
    end
  
  def signed_in?
      puts "signed_in3?  #{@current_user}"
      !current_user.nil?
      
  end
    
  def current_user=(user)
    puts "current_user=3  #{user}"
      @current_user = user
  end
  
  def current_user
      @current_user ||= User.find_by_remember_token(cookies[:remember_token])

  end
  
  def current_user?(user)
      user == current_user
  end
  
  def redirect_back_or(default)
      redirect_to(session[:return_to] || default)
      session.delete(:return_to)
    end
  
    # 在某个路径时发现没有登录，先保存这个路径，登录后返回
  def store_location
      session[:return_to] = request.fullpath
  end
  
  def signed_in_user
    unless signed_in?
           store_location
           redirect_to signin_path, notice: "Please sign in."
    end
  end
  
end
