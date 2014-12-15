class GameBoardsController < ApplicationController

  def index
    @game_boards = GameBoard.all
  end

  def new
    @game_board = GameBoard.new
    @game_board.save
    redirect_to edit_game_board_path(@game_board.id)
  end

  def edit
    @game_board = GameBoard.find_by(id: params[:id])
    redirect_to root_path unless @game_board
  end

  def update
    @game_board = GameBoard.find_by(id: params[:id])
    @game_board.update_attributes game_board_params

    if @game_board.completed?
      redirect_to root_path
    else
      redirect_to edit_game_board_path(@game_board.id)
    end
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
