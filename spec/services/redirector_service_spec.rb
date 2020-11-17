require 'rails_helper'

RSpec.describe RedirectorService do
	it "successfully generate salt for the uri" do 
		service = RedirectorService.new({ url: "http://www.google.com" })
		salt = service.send(:generate_salt)
		expect(salt).to match(/[a-z0-9]{10}/i)
	end

	it "successfully generate short url for the uri" do 
		service = RedirectorService.new({ url: "http://www.google.com" })
		result = service.create
		short_url = service.create[:short_url]
		expect(short_url).to match(/[a-z0-9]{5}/i)
	end

	it "successfully transforms short url to actual url" do 
		short_url = RedirectorService.new({ url: "http://www.google.com" }).create[:short_url]
		url = RedirectorService.new({short_url: short_url}).redirect[:url]
		expect(url).to match("http://www.google.com")
	end
end