class GameBoard < ActiveRecord::Base
  VALID_SQUARE_VALUES = [
    X = "x",
    O = "o"
  ]

  validates_inclusion_of :top_left, :top_middle, :top_right, :middle_left,
    :middle_middle, :middle_right, :bottom_left, :bottom_middle, :bottom_right,
    in: VALID_SQUARE_VALUES, allow_nil: true

end
