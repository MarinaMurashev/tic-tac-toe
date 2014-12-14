Rails.application.routes.draw do

  root 'game_boards#index'

  resources :game_boards
end
