class UrlsController < ApplicationController	
	def home
		render json: { status: "Ready to work!" }
	end

	def create
		result = service.create(params[:url])

		if result[:errors] 
			render json: { status: 'error', message: result[:errors] }
		else
			render json: { status: 'ok', short_url: result[:short_url] }
		end
	end

	def redirect
		result = service.redirect(params[:short_url])

		if result[:errors]
			render json: { status: 'error', message: result[:errors] }
		else
			redirect_to result[:url] 
		end
	end

	def stats
		result = service.stats(params[:short_url])

		if result[:errors] 
			render json: { status: 'error', message: result[:errors] }
		else
			render json: { staus: 'ok', counter: result[:counter] }
		end
	end

	private

	def service
		@service ||= RedirectorService.new
	end
end
