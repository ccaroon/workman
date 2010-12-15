################################################################################
# $Id: notes_controller.rb 1350 2008-10-06 16:41:48Z ccaroon $
################################################################################
ActionController::Routing::Routes.draw do |map|
  map.resources :countdowns

    map.resources :lists
    map.resources :scenarios
    map.resources :user_story_categories
    map.resources :user_stories
    map.resources :obstacles
    map.resources :goals
    map.resources :work_days
    map.resources :todos
    map.resources :entries
    map.resources :notes
    map.resources :users

    map.connect ':controller/:action/:id.:format'
    map.connect ':controller/:action/:id'
end
