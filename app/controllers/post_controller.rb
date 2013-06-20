class PostController < ApplicationController
  skip_before_action :verify_authenticity_token 
	before_action :login_check
	before_action :set_board

  def create
    @post = Post.where(id: post_params[:id]).first
    if @post
      unless @board.has_post? (@post)
        render nothing: true
        return
      end
      params = {top: post_params[:top].to_i, left: post_params[:left].to_i, story: post_params[:text], type: post_params[:type], location: post_params[:location]}
      @post.update_attributes(params)
    else
    	@post = current_user.write_post(post_params, @board)
    	@post.save
    end

    @board.links.each do |link|
      link.user.notify(@post)
    end

    respond_to do |format|
      format.json { render json: @post.id }
    end 
  end

  def destroy
    @post = Post.find(params[:post_id])
    unless @board.has_post? (@post)
      render nothing: true
      return
    end
    @post.destroy
  end

  private

  def set_board
  	@board = Board.find(params[:id])
  	redirect_to root_path, flash: { warning: '권한이 없습니다' } unless @board.has_member? (current_user)
  end

  def post_params
  	params.require(:post).permit(:id, :top, :left, :text, :type, :location)
  end
end
