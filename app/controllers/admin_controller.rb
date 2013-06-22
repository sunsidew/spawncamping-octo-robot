class AdminController < ApplicationController
	before_action :check_admin

  def index
  	@users = User.all
  end

  private
  def check_admin
  	render :file => "#{Rails.root}/public/404", :status => :not_found if current_user.id > 4
  end

end
