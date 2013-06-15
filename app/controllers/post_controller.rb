class PostController < ApplicationController
	before_action :login_check
	before_action :set_board

  def create
  	@post = current_user.write_post(post_params, @board)
  	if @post.save
  		render nothing: true
  	else
  		render nothing: true
  	end
  end

  def update
  
  end

  def destroy

  end

  private
  def set_board
  	@board = Board.find(params[:id])
  	redirect_to root_path, flash: { warning: '권한이 없습니다' } unless @board.has_member? (current_user)
  end

  def post_params
  	params.require(:post).permit(:top, :left, :story)
  end
end
