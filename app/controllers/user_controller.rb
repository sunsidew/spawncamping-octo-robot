class UserController < ApplicationController
  def search
  	@users = User.where("name like ?", params[:query]+"%")

  	respond_to do |format|
  		format.json { render json: @users }
  	end
  end
end
