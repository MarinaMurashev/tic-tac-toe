class CreateGameBoards < ActiveRecord::Migration
  def change
    create_table :game_boards do |t|
      t.string :top_left
      t.string :top_middle
      t.string :top_right
      t.string :middle_left
      t.string :middle_middle
      t.string :middle_right
      t.string :bottom_left
      t.string :bottom_middle
      t.string :bottom_right
    end
  end
end
