require 'rails_helper'

describe GameBoard do

  let(:x) { GameBoard::X }
  let(:o) { GameBoard::O }

  describe "#valid" do

    it "is not valid with a value other than 'x' 'o' or nil" do
      expect(build(:game_board, top_right: "y")).to_not be_valid
    end

    it "is x if o was submitted last" do
      game_board = create(:empty_game_board, top_right: x, top_left: o)
      game_board.bottom_left = o
      expect(game_board).to_not be_valid
    end

    it "is o if x was submitted last" do
      game_board = create(:empty_game_board, top_right: x, top_left: o, bottom_right: x)
      game_board.bottom_left = x
      expect(game_board).to_not be_valid
    end

    it "is x if no squares were submitted yet" do
      game_board = create(:empty_game_board)
      game_board.top_right = o
      expect(game_board).to_not be_valid
    end
  end

  describe "#completed?" do

    it "is true when game board has 3 x's in a row horizontally" do
      game_board = create :empty_game_board, top_left: x, top_middle: x,
        top_right: x, middle_left: o, bottom_right: o
      expect(game_board.completed?).to be_truthy
    end

    it "is true when game board has 3 x's in a row vertically" do
      game_board = create :empty_game_board, top_left: x, middle_left: x,
        middle_right: o, bottom_left: x, bottom_middle: o
      expect(game_board.completed?).to be_truthy
    end

    it "is true when game board has 3 x's in a row diagonally" do
      game_board = create :empty_game_board, top_left: x, top_right: o,
        middle_middle: x, bottom_middle: o, bottom_right: x
      expect(game_board.completed?).to be_truthy
    end

    it "is false when game board doesn't have all fields set and doesn't have 3 x's in a row" do
      game_board = create :empty_game_board, top_left: x, top_middle: o,
        middle_middle: o, middle_right: x, bottom_left: x
      expect(game_board.completed?).to be_falsey
    end

    it "is true when game board has 3 o's in a row horizontally" do
      game_board = create :empty_game_board, top_right: x, middle_left: o,
        middle_middle: o, middle_right: o, bottom_left: x, bottom_middle: x
      expect(game_board.completed?).to be_truthy
    end

    it "is true when game board has 3 o's in a row vertically" do
      game_board = create :empty_game_board, top_middle: x, top_right: o,
        middle_left: x, middle_right: o, bottom_middle: x, bottom_right: o
      expect(game_board.completed?).to be_truthy
    end

    it "is true when game board has 3 o's in a row diagonally" do
      game_board = create :empty_game_board, top_middle: x, top_right: o,
        middle_middle: o, bottom_left: o, bottom_middle: x, bottom_right: x
      expect(game_board.completed?).to be_truthy
    end

    it "is false when game board doesn't have all fields set and doesn't have 3 o's in a row" do
      game_board = create :empty_game_board, top_left: x, top_middle: o,
        top_right: x, middle_middle: o, bottom_middle: x, bottom_right: o
      expect(game_board.completed?).to be_falsey
    end

    it "is true when game board has all fields set" do
      game_board = create :game_board_tie
      expect(game_board.completed?).to be_truthy
    end
  end
end
