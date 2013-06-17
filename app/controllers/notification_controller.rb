class NotificationController < ApplicationController
  def show
  	@notification = Notification.find(params[:id])
  	@notification.update_attributes(flag: 0)
  	redirect_to @notification.post.board
  end
end
