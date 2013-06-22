class PostController < ApplicationController
  skip_before_action :verify_authenticity_token 
	before_action :set_board

  def create
    @post = Post.where(id: post_params[:id]).first
    if @post
      unless @board.has_post? (@post)
        render status: 422
        return
      end

      if @post.user == current_user or @board.is_owner? (current_user)
        params = {top: post_params[:top].to_i, left: post_params[:left].to_i, story: post_params[:text], type: post_params[:type]}
        @post.update_attributes(params)
      else
        render status: 422
        return
      end
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
      render status: 422
      return
    end

    if @post.user == current_user or @board.is_owner? (current_user)
      @post.destroy
    else
      render status: 422
      return 
    end
  end

  def move_location
    puts params.inspect
    @post = Post.where(id: params[:post_id]).first
    if @post
      if @post.user == current_user or @board.is_owner? (current_user)
        @post.location = (@post.location == "main" ? "temp" : "main")
        @post.save
        render nothing: true
      end
    else
      render nothing: true, status: 422
    end
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
