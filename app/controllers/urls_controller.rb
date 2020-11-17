class UrlsController < ApplicationController	
	def create
		status :ok
	end

	def show
		status :ok
	end

	def stats
		status :ok
	end

	private

	def service
		@service ||= RedirectorService.new
	end
end
