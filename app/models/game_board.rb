class GameBoard < ActiveRecord::Base

  validate :x_is_first, :correct_turn

  before_validation :nil_if_blank

  NILABLE_FIELDS = %w(top_left top_middle top_right middle_left middle_middle middle_right bottom_left bottom_middle bottom_right)

  VALID_SQUARE_VALUES = [
    X = "x",
    O = "o"
  ]

  SQUARE_SIZE = 3

  validates_inclusion_of :top_left, :top_middle, :top_right, :middle_left,
    :middle_middle, :middle_right, :bottom_left, :bottom_middle, :bottom_right,
    in: VALID_SQUARE_VALUES, allow_nil: true

  def completed?
    three_horizontally? || three_vertically? || three_diagonally? || all_filled_in?
  end

  private

  def three_horizontally?
    return true if identical_non_nil_values?(top_left, top_middle, top_right)
    return true if identical_non_nil_values?(middle_left, middle_middle, middle_right)
    return true if identical_non_nil_values?(bottom_left, bottom_middle, bottom_right)
  end

  def three_vertically?
    return true if identical_non_nil_values?(top_left, middle_left, bottom_left)
    return true if identical_non_nil_values?(top_middle, middle_middle, bottom_middle)
    return true if identical_non_nil_values?(top_right, middle_right, bottom_right)
  end

  def three_diagonally?
    return true if identical_non_nil_values?(top_left, middle_middle, bottom_right)
    return true if identical_non_nil_values?(top_right, middle_middle, bottom_left)
  end

  def identical_non_nil_values?(*square_array)
    non_nil_array = square_array.compact
    non_nil_array.size == SQUARE_SIZE && non_nil_array.uniq.size == 1
  end

  def all_filled_in?
    top_left && top_middle && top_right && middle_left && middle_middle &&
      middle_right && bottom_left && bottom_middle && bottom_right
  end

  def nil_if_blank
    NILABLE_FIELDS.each{ |attr| self[attr] = nil if self[attr].blank? }
  end

  def x_is_first
    num_non_nil_fields = 0
    NILABLE_FIELDS.each do |field|
      next if field == self.changed.first
      num_non_nil_fields += 1 if self[field].present?
    end

    if num_non_nil_fields == 0 && self.changed.first == O
      errors.add(self.changed.first.to_sym, "must be #{X}")
    end
  end

  def correct_turn
    num_x = num_o = 0

    NILABLE_FIELDS.each do |field|
      next if field == self.changed.first
      num_x += 1 if self[field] == X
      num_o += 1 if self[field] == O
    end

    if num_x == num_o && self[self.changed.first] == O
      errors.add(self.changed.first.to_sym, "must be #{X}")
    end

    if num_x > num_o && self[self.changed.first] == X
      errors.add(self.changed.first.to_sym, "must be #{O}")
    end
  end
end
