module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user?(user)
    user == current_user
  end 

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def redirect_back default_url
    redirect_to(session[:forwarding_url] || default_url)
    session.delete(:forwarding_url)
  end  
end
