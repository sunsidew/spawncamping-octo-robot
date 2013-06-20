class BoardsController < ApplicationController
  before_action :login_check
  before_action :set_board, only: [:show, :edit, :update, :destroy, :add_member, :remove_member, :show_main, :show_temp]

  # GET /boards
  # GET /boards.json
  def index
    @links = Link.where(user_id: current_user.id)
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    @posts = @board.main_posts
    render layout: 'main_board'
  end

  def show_main
    @posts = @board.main_posts
    render 'show', layout: 'main_board'
  end

  def show_temp
    @posts = @board.temp_posts
    render layout: 'main_board'
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards
  # POST /boards.json
  def create
    @board = Board.new(board_params)
    @board.add_member(current_user, 10)

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: 'Board was successfully created.' }
        format.json { render action: 'show', status: :created, location: @board }
      else
        format.html { render action: 'new' }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board, notice: 'Board was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url }
      format.json { head :no_content }
    end
  end

  def add_member
    @user = User.find(params[:user_id])

    unless @board.has_member? (@user)
      @board.add_member(@user, 10)

      respond_to do |format|
        format.json { render json: @user }
      end
    else
      respond_to do |format|
        format.json { render json: { error: '이미 있어요' }, status: 422 }
      end

    end
  end

  def remove_member
    @user = User.find(params[:user_id])
    @board.remove_member(@user) unless @board.has_member? (@user)

    respond_to do |format|
      format.json { render json: @user }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
      redirect_to root_path, flash: { warning: '권한이 없습니다' } unless @board.has_member? (current_user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:name, :description)
    end
end
