require 'rails_helper'

describe GameBoard do

  describe "#valid" do

    it "has top_left with values 'x' or 'o'" do
      expect(build(:game_board_incomplete, top_left: "y")).to_not be_valid
    end
  end
end
