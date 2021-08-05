Rails.application.routes.draw do
  get '/meals/' => "meals#index"
  get '/meals/:id' => "meals#show"
  post '/meals/new' => "meals#create"
  put '/meals/update' => "meals#update"
  delete '/meals/destroy' => "meals#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
