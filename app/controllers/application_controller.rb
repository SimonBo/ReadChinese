class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :store_location 

  def store_location
    session[:previous_url] = request.fullpath 
  end
end
