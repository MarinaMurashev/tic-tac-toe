class GameBoard < ActiveRecord::Base
  VALID_SQUARE_VALUES = [
    X = "x",
    O = "o"
  ]

  validates_inclusion_of :top_left, :top_middle, :top_right, :middle_left,
    :middle_middle, :middle_right, :bottom_left, :bottom_middle, :bottom_right,
    in: VALID_SQUARE_VALUES, allow_nil: true

  def completed?
    has_three_horizontally || has_three_vertically || has_three_diagonally || has_all_filled_in
  end

  private

  def has_three_horizontally
    return true if has_identical_non_nil_values([top_left, top_middle, top_right])
    return true if has_identical_non_nil_values([middle_left, middle_middle, middle_right])
    return true if has_identical_non_nil_values([bottom_left, bottom_middle, bottom_right])
  end

  def has_three_vertically
    return true if has_identical_non_nil_values([top_left, middle_left, bottom_left])
    return true if has_identical_non_nil_values([top_middle, middle_middle, bottom_middle])
    return true if has_identical_non_nil_values([top_right, middle_right, bottom_right])
  end

  def has_three_diagonally
    return true if has_identical_non_nil_values([top_left, middle_middle, bottom_right])
    return true if has_identical_non_nil_values([top_right, middle_middle, bottom_left])
  end

  def has_identical_non_nil_values(square_array)
    non_nil_array = square_array.compact
    non_nil_array.size == 3 && non_nil_array.uniq.size == 1
  end

  def has_all_filled_in
    top_left && top_middle && top_right && middle_left && middle_middle &&
      middle_right && bottom_left && bottom_middle && bottom_right
  end
end
