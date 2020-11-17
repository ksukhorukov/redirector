class UrlsController < ApplicationController	
	def home
		render json: { status: "Ready to work!" }
	end

	def create
		render json: @service.create(params[:short_url])
	end

	def redirect
		url, error = @service.redirect(params[:short_url])

		if error 
			render json: { status: 'error', message: error }
		else
			redirect_to url 
		end
	end

	def stats
		counter, error = @service.stats(params[:short_url])

		if error 
			render json: { status: 'error', message: error }
		else
			render json: { staus: 'ok', counter: counter }
		end
	end

	private

	def service
		@service ||= RedirectorService.new
	end
end
