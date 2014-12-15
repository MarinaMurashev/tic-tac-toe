require 'rails_helper'

describe GameBoard do

  describe "#valid" do
    let(:non_valid_square_value) { "y" }

    it "has top_left with values 'x' or 'o' or nil" do
      expect(build(:game_board, top_left: non_valid_square_value)).to_not be_valid
      expect(build(:game_board, top_left: "x")).to be_valid
      expect(build(:game_board, top_left: "o")).to be_valid
      expect(build(:game_board, top_left: nil)).to be_valid
    end

    it "has top_middle with values 'x' or 'o' or nil" do
      expect(build(:game_board, top_middle: non_valid_square_value)).to_not be_valid
      expect(build(:game_board, top_middle: "x")).to be_valid
      expect(build(:game_board, top_middle: "o")).to be_valid
      expect(build(:game_board, top_middle: nil)).to be_valid
    end

    it "has top_right with values 'x' or 'o' or nil" do
      expect(build(:game_board, top_right: non_valid_square_value)).to_not be_valid
      expect(build(:game_board, top_right: "x")).to be_valid
      expect(build(:game_board, top_right: "o")).to be_valid
      expect(build(:game_board, top_right: nil)).to be_valid
    end

    it "has middle_left with values 'x' or 'o' or nil" do
      expect(build(:game_board, middle_left: non_valid_square_value)).to_not be_valid
      expect(build(:game_board, middle_left: "x")).to be_valid
      expect(build(:game_board, middle_left: "o")).to be_valid
      expect(build(:game_board, middle_left: nil)).to be_valid
    end

    it "has middle_middle with values 'x' or 'o' or nil" do
      expect(build(:game_board, middle_middle: non_valid_square_value)).to_not be_valid
      expect(build(:game_board, middle_middle: "x")).to be_valid
      expect(build(:game_board, middle_middle: "o")).to be_valid
      expect(build(:game_board, middle_middle: nil)).to be_valid
    end

    it "has middle_right with values 'x' or 'o' or nil" do
      expect(build(:game_board, middle_right: non_valid_square_value)).to_not be_valid
      expect(build(:game_board, middle_right: "x")).to be_valid
      expect(build(:game_board, middle_right: "o")).to be_valid
      expect(build(:game_board, middle_right: nil)).to be_valid
    end

    it "has bottom_left with values 'x' or 'o' or nil" do
      expect(build(:game_board, bottom_left: non_valid_square_value)).to_not be_valid
      expect(build(:game_board, bottom_left: "x")).to be_valid
      expect(build(:game_board, bottom_left: "o")).to be_valid
      expect(build(:game_board, bottom_left: nil)).to be_valid
    end

    it "has bottom_middle with values 'x' or 'o' or nil" do
      expect(build(:game_board, bottom_middle: non_valid_square_value)).to_not be_valid
      expect(build(:game_board, bottom_middle: "x")).to be_valid
      expect(build(:game_board, bottom_middle: "o")).to be_valid
      expect(build(:game_board, bottom_middle: nil)).to be_valid
    end

    it "has bottom_right with values 'x' or 'o' or nil" do
      expect(build(:game_board, bottom_right: non_valid_square_value)).to_not be_valid
      expect(build(:game_board, bottom_right: "x")).to be_valid
      expect(build(:game_board, bottom_right: "o")).to be_valid
      expect(build(:game_board, bottom_right: nil)).to be_valid
    end
  end

  describe "#completed?" do

    it "is true when game board has 3 x's in a row horizontally" do
      game_board = create :empty_game_board, top_left: "x", top_middle: "x",
        top_right: "x", middle_left: "o", bottom_right: "o"
      expect(game_board.completed?).to be_truthy
    end

    it "is true when game board has 3 x's in a row vertically" do
      game_board = create :empty_game_board, top_left: "x", middle_left: "x",
        middle_right: "o", bottom_left: "x", bottom_middle: "o"
      expect(game_board.completed?).to be_truthy
    end

    it "is true when game board has 3 x's in a row diagonally" do
      game_board = create :empty_game_board, top_left: "x", top_right: "o",
        middle_middle: "x", bottom_middle: "o", bottom_right: "x"
      expect(game_board.completed?).to be_truthy
    end

    it "is false when game board doesn't have all fields set and doesn't have 3 x's in a row" do
      game_board = create :empty_game_board, top_left: "x", top_middle: "o",
        middle_middle: "o", middle_right: "x", bottom_left: "x"
      expect(game_board.completed?).to be_falsey
    end

    it "is true when game board has 3 o's in a row horizontally" do
      game_board = create :empty_game_board, top_right: "x", middle_left: "o",
        middle_middle: "o", middle_right: "o", bottom_left: "x", bottom_middle: "x"
      expect(game_board.completed?).to be_truthy
    end

    it "is true when game board has 3 o's in a row vertically" do
      game_board = create :empty_game_board, top_middle: "x", top_right: "o",
        middle_left: "x", middle_right: "o", bottom_middle: "x", bottom_right: "o"
      expect(game_board.completed?).to be_truthy
    end

    it "is true when game board has 3 o's in a row diagonally" do
      game_board = create :empty_game_board, top_middle: "x", top_right: "o",
        middle_middle: "o", bottom_left: "o", bottom_middle: "x", bottom_right: "x"
      expect(game_board.completed?).to be_truthy
    end

    it "is false when game board doesn't have all fields set and doesn't have 3 o's in a row" do
      game_board = create :empty_game_board, top_left: "x", top_middle: "o",
        top_right: "x", middle_middle: "o", bottom_middle: "x", bottom_right: "o"
      expect(game_board.completed?).to be_falsey
    end

    it "is true when game board has all fields set" do
      game_board = create :game_board_tie
      expect(game_board.completed?).to be_truthy
    end
  end
end
