# frozen_string_literal: true

class UrlsController < ApplicationController
  def home
    render json: { status: 'Ready to work!' }
  end

  def create
    result = service.create

    if result[:errors]
      render json: { status: 'error', message: result[:errors] }, status: :unprocessable_entity
    else
      render json: { status: 'ok', short_url: result[:short_url] }, status: :created
    end
  end

  def redirect
    result = service.redirect

    if result[:errors]
      render json: { status: 'error', message: result[:errors] }, status: :unprocessable_entity
    else
      redirect_to result[:url]
    end
  end

  def stats
    result = service.stats

    if result[:errors]
      render json: { status: 'error', message: result[:errors] }, status: :unprocessable_entity
    else
      render json: { staus: 'ok', counter: result[:counter] }, status: :ok
    end
  end

  private

  def service
    @service ||= RedirectorService.new(params)
  end
end
