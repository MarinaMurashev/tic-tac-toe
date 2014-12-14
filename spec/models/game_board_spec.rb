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
end
