Rails.application.routes.draw do
  get '/meals/' => "meals#index"
  post '/meals/import' => "meals#import"
  get '/meals/:id' => "meals#show"
  post '/meals/new' => "meals#create"
  put '/meals/:id' => "meals#update"
  delete '/meals/:id' => "meals#destroy"
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end