ActionController::Routing::Routes.draw do |map|
  map.resources :flexifield_defs, :has_many => :flexifield_def_entries
end