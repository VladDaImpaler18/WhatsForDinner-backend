Rails.application.routes.draw do
  get '/meals/' => "meals#index"
  get '/meals/:id' => "meals#show"
  post '/meals/new' => "meals#create"
  put '/meals/:id' => "meals#update"
  delete '/meals/:id' => "meals#destroy"
  post '/meals/import' => "meals#import"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end