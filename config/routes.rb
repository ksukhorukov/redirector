Rails.application.routes.draw do
  post '/urls', to: 'urls#create'
  get '/urls/:short_url', to: 'urls#show'
  get '/urls/:short_url/stats', to: 'urls#stats' 
end
