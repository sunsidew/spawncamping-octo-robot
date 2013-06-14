class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login_check
  	redirect_to login_path, flash: { warning: '로그인 먼저 하세요' } unless current_user
  end

  def current_user
  	@current_user = User.where(id: session[:user_id]).first
  end
  helper_method :current_user
end
