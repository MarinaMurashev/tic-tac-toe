class GameBoard < ActiveRecord::Base
  VALID_SQUARE_VALUES = ["x", "o"]

  validates_inclusion_of :top_left, in: VALID_SQUARE_VALUES

end
