require 'securerandom'
require 'digest'


class RedirectorService
	RECORD_NOT_FOUND_ERROR = 'Record not found'

	def create(url)
		record = Url.create(url: url, short_url: generate_short_url(url)) 

		if record.errors?
			{ errors: record.errors.messages }
		else
			{ short_url: record.short_url }
		end
	end

	def redirect(short_url)
		record = Url.where(short_url: short_url).first

		if record 
			record.counter += 1
			record.save
			
			{ url: record.url }
		else
			{ errors: RECORD_NOT_FOUND_ERROR }
		end
	end

	def stats(short_url)
		record = Url.where(short_url: short_url).first

		if record 
			{ counter: record.counter }
		else
			{ errors: RECORD_NOT_FOUND_ERROR }
		end
	end

	private

	def generate_short_url(url)
		digest = Digest::MD5.hexdigest(url + generate_salt)
		short_url = digest[0, 5]

		return generate_short_url(url) if short_url_exist?(short_url)
			
		short_url
	end

	def generate_salt
		SecureRandom.alphanumeric(10)
	end

	def short_url_exist?(short_url)
		Url.where(short_url: short_url).first
	end
end

