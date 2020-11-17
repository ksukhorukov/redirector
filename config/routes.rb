# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'urls#home'

  post '/urls', to: 'urls#create'
  get '/urls/:short_url', to: 'urls#redirect'
  get '/urls/:short_url/stats', to: 'urls#stats'
end
