FactoryGirl.define do
  factory :game_board_incomplete, class: GameBoard do
    top_left "x"
    top_middle "o"
    top_right "x"
    middle_left nil
    middle_middle nil
    middle_right nil
    bottom_left nil
    bottom_middle nil
    bottom_right nil
  end

  factory :game_board_tie, class: GameBoard do
    top_left "x"
    top_middle "x"
    top_right "o"
    middle_left "o"
    middle_middle "o"
    middle_right "x"
    bottom_left "x"
    bottom_middle "o"
    bottom_right "o"
  end

  factory :game_board_with_x_winner, class: GameBoard do
    top_left "x"
    top_middle "x"
    top_right "x"
    middle_left "o"
    middle_middle nil
    middle_right nil
    bottom_left nil
    bottom_middle nil
    bottom_right "o"
  end
end
