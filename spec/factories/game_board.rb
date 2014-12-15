FactoryGirl.define do

  factory :game_board do
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
    top_middle "o"
    top_right "o"
    middle_left "o"
    middle_middle "x"
    middle_right "x"
    bottom_left "x"
    bottom_middle "x"
    bottom_right "o"
  end

  factory :empty_game_board, class: GameBoard do
    top_left nil
    top_middle nil
    top_right nil
    middle_left nil
    middle_middle nil
    middle_right nil
    bottom_left nil
    bottom_middle nil
    bottom_right nil
  end
end
