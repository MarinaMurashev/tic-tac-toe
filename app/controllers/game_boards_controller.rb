class GameBoardsController < ApplicationController

  def index
    @game_boards = GameBoard.all
  end

  def create
    @game_board = GameBoard.create!
    redirect_to edit_game_board_path(@game_board.id)
  end

  def edit
    @game_board = GameBoard.find_by(id: params[:id])
    redirect_to root_path unless @game_board && !@game_board.completed?
  end

  def update
    @game_board = GameBoard.find_by(id: params[:id])
    return redirect_to root_path unless @game_board

    unless @game_board.update_attributes game_board_params
      flash[:error] = @game_board.errors.full_messages.uniq.join(", ")
    end

    if @game_board.completed?
      redirect_to game_board_path(@game_board.id)
    else
      redirect_to edit_game_board_path(@game_board.id)
    end
  end

  def show
    @game_board = GameBoard.find_by(id: params[:id])
    redirect_to root_path unless @game_board
  end

  private

  def game_board_params
    params.require(:game_board).permit(
      :top_left,
      :top_middle,
      :top_right,
      :middle_left,
      :middle_middle,
      :middle_right,
      :bottom_left,
      :bottom_middle,
      :bottom_right
    )
  end

end
