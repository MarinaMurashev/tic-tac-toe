class GameBoard < ActiveRecord::Base

  validate :x_is_first, :correct_turn, :one_submission, :not_overwriting, :not_all_blank, on: [:update]
  validate :has_correct_ratio_of_x_to_o, on: [:create]

  before_validation :nil_if_blank, :lowercase_the_values

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

  def winners
    return [X, O] if completed? && !three_horizontally? && !three_vertically? && !three_diagonally?
    return [X] if completed? && player_num_in_fields(X) > player_num_in_fields(O)
    return [O] if completed? && player_num_in_fields(X) == player_num_in_fields(O)
    []
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

  def lowercase_the_values
    NILABLE_FIELDS.each{ |attr| self[attr] = self[attr].try(:downcase) }
  end

  def x_is_first
    num_non_nil_fields = 0
    NILABLE_FIELDS.each do |field|
      next if field == self.changed.first
      num_non_nil_fields += 1 if self[field].present?
    end

    if num_non_nil_fields == 0 && self.changed.first == O
      self.errors[:base] << "#{X.capitalize} goes first"
    end
  end

  def correct_turn
    num_x = player_num_in_fields(X, self.changed.first)
    num_o = player_num_in_fields(O, self.changed.first)

    if num_x == num_o && self[self.changed.first] == O
      self.errors[:base] << "It is #{X.capitalize}'s turn"
    end

    if num_x > num_o && self[self.changed.first] == X
      self.errors[:base] << "It is #{O.capitalize}'s turn"
    end
  end

  def one_submission
    if self.changed.size > 1
      self.errors[:base] << "You can only submit one."
    end
  end

  def not_overwriting
    if self.changed.present? && self.changes[self.changed.first].first.present?
      self.errors[:base] << "You cannot overwrite a previous submission"
    end
  end

  def player_num_in_fields(player, skip_field = nil)
    NILABLE_FIELDS.inject(0) do |result, field|
      if skip_field && field == skip_field
        result
      else
        result += 1 if self[field] == player
        result
      end
    end
  end

  def not_all_blank
    unless NILABLE_FIELDS.detect{ |field| self[field].present? }
      self.errors[:base] << "You cannot submit an empty game board."
    end
  end

  def has_correct_ratio_of_x_to_o
    num_x = player_num_in_fields(X)
    num_o = player_num_in_fields(O)
    sum_x_o = num_x + num_o

    wrong_odd_combination = sum_x_o.odd? && (num_x - num_o) != 1
    wrong_even_combination = sum_x_o.even? && num_x != num_o

    if wrong_even_combination || wrong_odd_combination
      self.errors[:base] << "You must submit a valid game"
    end
  end
end
