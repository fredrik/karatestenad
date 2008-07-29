ActionController::Routing::Routes.draw do |map|
  map.resources :words

  map.root :controller => "words"

  map.redirect '/define/:id', :controller => 'words', :action => 'show'
  map.connect ':id', :controller => 'words', :action => 'show'


end
