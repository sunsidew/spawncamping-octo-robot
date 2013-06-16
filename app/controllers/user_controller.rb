class UserController < ApplicationController
	before_action :login_check
  def search
  	puts '####'+params.inspect
  end
end
