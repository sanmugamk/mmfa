class ApplicationController < ActionController::Base
  
 # before_filter :prepare_for_mobile
  layout :detect_browser
  helper :all # include all helpers, all the time
  
  # Return the value for a given setting
  def s(identifier)
    Setting.get(identifier)
  end
  helper_method :s
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '9fe6825f97cc334d88925fde5c4808a8'
  
  alias :logged_in? :user_signed_in?
  helper_method :logged_in?

  layout :layout_by_resource  
  def layout_by_resource
    if devise_controller? 
      "login"
    else
      "application"
    end
  end
  
#mobile browser
private
  MOBILE_BROWSERS = ["android", "ipod", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]

  def detect_browser
    agent = request.headers["HTTP_USER_AGENT"].downcase
    MOBILE_BROWSERS.each do |m|
      return "mobile_application" if agent.match(m)
    end
    return "application"
  end  
  
=begin   
  private

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end
=end
end
