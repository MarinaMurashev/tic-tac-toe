require 'rails_helper'

describe GameBoardsController do

  describe "GET#index"do

    it "sets the game_boards instance variable to all game boards" do
      game_board1 = create :game_board
      game_board2 = create :game_board

      get :index
      expect(assigns(:game_boards)).to match_array [game_board1, game_board2]
    end
  end

  describe "GET#new" do

    it "creates a new game board record" do
      expect{ get :new}.to change(GameBoard, :count).by(1)
    end

    it "redirects to the edit page of the new game board record" do
      get :new
      game_board_id = assigns(:game_board).id
      expect(response).to redirect_to edit_game_board_path(game_board_id)
    end
  end

  describe "GET#edit" do

    let(:game_board) { create :game_board }

    it "assigns the game board instance to the one associated with the provided id" do
      get :edit, id: game_board.id
      expect(assigns(:game_board)).to eq game_board
    end

    it "redirects to root path if the provided id is not associated with a game board" do
      get :edit, id: (game_board.id + 1)
      expect(response).to redirect_to root_path
    end
  end

  describe "PUT#update" do

    describe "when game is complete" do

      it "renders the show page of the gameboard if game is complete"
    end

    describe "when game is not complete" do

      it "redirects to the edit page of the same gameboard if game is not complete"
    end
  end
end
