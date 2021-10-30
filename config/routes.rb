Rails.application.routes.draw do
  get '/meals/' => "meals#index"
  post '/meals/import' => "meals#import"
  post '/meals/new' => "meals#create"
  get '/meals/:id' => "meals#show"
  put '/meals/:id' => "meals#update"
  delete '/meals/:id' => "meals#destroy"
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end