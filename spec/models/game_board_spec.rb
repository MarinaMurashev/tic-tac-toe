require 'rails_helper'

describe GameBoard do

  let(:x) { GameBoard::X }
  let(:o) { GameBoard::O }

  describe "#valid" do

    describe "inclusion of correct values" do
      let (:non_valid_square_value) { "y" }

      it "has top_left with values 'x' or 'o' or nil" do
        expect(build(:empty_game_board, top_left: non_valid_square_value)).to_not be_valid
        expect(build(:empty_game_board, top_left: x)).to be_valid
        expect(build(:empty_game_board, top_left: o, top_right: x)).to be_valid
        expect(build(:empty_game_board, top_left: nil)).to be_valid
      end

      it "has top_middle with values 'x' or 'o' or nil" do
        expect(build(:empty_game_board, top_middle: non_valid_square_value)).to_not be_valid
        expect(build(:empty_game_board, top_middle: x)).to be_valid
        expect(build(:empty_game_board, top_middle: o, top_right: x)).to be_valid
        expect(build(:empty_game_board, top_middle: nil)).to be_valid
      end

      it "has top_right with values 'x' or 'o' or nil" do
        expect(build(:empty_game_board, top_right: non_valid_square_value)).to_not be_valid
        expect(build(:empty_game_board, top_right: x)).to be_valid
        expect(build(:empty_game_board, top_right: o, top_right: x)).to be_valid
        expect(build(:empty_game_board, top_right: nil)).to be_valid
      end

      it "has middle_left with values 'x' or 'o' or nil" do
        expect(build(:empty_game_board, middle_left: non_valid_square_value)).to_not be_valid
        expect(build(:empty_game_board, middle_left: x)).to be_valid
        expect(build(:empty_game_board, middle_left: o, top_right: x)).to be_valid
        expect(build(:empty_game_board, middle_left: nil)).to be_valid
      end

      it "has middle_middle with values 'x' or 'o' or nil" do
        expect(build(:empty_game_board, middle_middle: non_valid_square_value)).to_not be_valid
        expect(build(:empty_game_board, middle_middle: x)).to be_valid
        expect(build(:empty_game_board, middle_middle: o, top_right: x)).to be_valid
        expect(build(:empty_game_board, middle_middle: nil)).to be_valid
      end


      it "has middle_right with values 'x' or 'o' or nil" do
        expect(build(:empty_game_board, middle_right: non_valid_square_value)).to_not be_valid
        expect(build(:empty_game_board, middle_right: x)).to be_valid
        expect(build(:empty_game_board, middle_right: o, top_right: x)).to be_valid
        expect(build(:empty_game_board, middle_right: nil)).to be_valid
      end

      it "has bottom_left with values 'x' or 'o' or nil" do
        expect(build(:empty_game_board, bottom_left: non_valid_square_value)).to_not be_valid
        expect(build(:empty_game_board, bottom_left: x)).to be_valid
        expect(build(:empty_game_board, bottom_left: o, top_right: x)).to be_valid
        expect(build(:empty_game_board, bottom_left: nil)).to be_valid
      end

      it "has bottom_middle with values 'x' or 'o' or nil" do
        expect(build(:empty_game_board, bottom_middle: non_valid_square_value)).to_not be_valid
        expect(build(:empty_game_board, bottom_middle: x)).to be_valid
        expect(build(:empty_game_board, bottom_middle: o, top_right: x)).to be_valid
        expect(build(:empty_game_board, bottom_middle: nil)).to be_valid
      end

      it "has bottom_right with values 'x' or 'o' or nil" do
        expect(build(:empty_game_board, bottom_right: non_valid_square_value)).to_not be_valid
        expect(build(:empty_game_board, bottom_right: x)).to be_valid
        expect(build(:empty_game_board, bottom_right: o, top_right: x)).to be_valid
        expect(build(:empty_game_board, bottom_right: nil)).to be_valid
      end
    end

    describe "on create" do
      it "is empty for the entire board" do
        expect(build(:empty_game_board)).to be_valid
      end

      it "has 1 more x than o if there is an odd number of squares filled in" do
        expect(
          build(:empty_game_board, top_left: x, top_right: o, top_middle: x)
        ).to be_valid

        expect(
          build(:empty_game_board, top_left:x, top_right: o, top_middle: x, bottom_right: o, bottom_left: o)
        ).to_not be_valid
      end

      it "has an equal number of x and o if there is an even number of squares filled in" do
        expect(
          build(:empty_game_board, top_left: x, top_right: o, top_middle: x, bottom_left: o)
        ).to be_valid

        expect(
          build(:empty_game_board, top_left: x, top_right: o, top_middle: x, bottom_left: x)
        ).to_not be_valid
      end
    end

    describe "on update" do

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

      it "is not valid when more than one attribute is being updated" do
        game_board = create(:empty_game_board)
        game_board.top_right = o
        game_board.top_left = x
        expect(game_board).to_not be_valid
      end

      it "is not valid when the attribute being updated is not nil" do
        game_board = create(:empty_game_board, top_right: x, top_left: o)
        game_board.top_left = x
        expect(game_board).to_not be_valid
      end

      it "is not valid when all attributes are nil" do
        game_board = create(:empty_game_board)
        game_board.top_right = game_board.top_middle = game_board.top_left = nil
        game_board.middle_right = game_board.middle_middle = game_board.middle_left = nil
        game_board.bottom_right = game_board.bottom_middle = game_board.bottom_left = nil
        expect(game_board).to_not be_valid
      end
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

  describe "#winners" do

    it "is x when x has 3 in a row" do
      game_board = create(:empty_game_board, top_left: x, top_middle: x,
        top_right: x, bottom_middle: o, bottom_right: o)
      expect(game_board.winners).to eq [x]
    end

    it "is o when o has 3 in a row" do
      game_board = create(:empty_game_board, top_left: o, top_middle: o,
        top_right: o, bottom_right: x, bottom_middle: x, middle_middle: x)
      expect(game_board.winners).to eq [o]
    end

    it "is both x and o when neither has 3 in a row" do
      game_board = create(:game_board_tie)
      expect(game_board.winners).to match_array [x, o]
    end

    it "is neither when game is incomplete and neither has 3 in a row" do
      game_board = create(:empty_game_board, top_left: x, top_right: o)
      expect(game_board.winners).to eq []
    end
  end
end
