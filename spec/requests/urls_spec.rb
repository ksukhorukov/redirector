# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Urls', type: :request do
  describe 'POST /urls' do
    it 'creates short url' do
      post urls_path, params: {
        url: 'http://www.google.com'
      }

      expect(response).to have_http_status(201)
    end

    it 'fails to create short url due to incorrect original url' do
      post urls_path, params: {
        url: 'incorrect-url'
      }

      expect(response).to have_http_status(422)
    end
  end

  describe 'GET /urls/:short_url' do
    it 'transforms correct short url to original url and redirects' do
      post urls_path, params: {
        url: 'http://www.google.com'
      }

      short_url = JSON.parse(response.body)['short_url']

      get "/urls/#{short_url}"

      expect(response).to have_http_status(302)
    end

    it 'fails to redirect when incorrect short url provided' do
      get '/urls/non-existing-short-url'

      expect(response).to have_http_status(422)
    end
  end

  describe 'GET /urls/:short_url/stats' do
    it 'responds with correct statistic when correct short url provided' do
      post urls_path, params: {
        url: 'http://www.google.com'
      }

      short_url = JSON.parse(response.body)['short_url']

      get "/urls/#{short_url}"

      get "/urls/#{short_url}/stats"

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['counter']).to eq(1)
    end

    it 'responds with error when incorrect short url provided' do
      get '/urls/incorrect-short-url/stats'

      expect(response).to have_http_status(422)
    end
  end
end
