require 'rails_helper'

RSpec.describe RedirectorService do
	it "successfully generates salt for the uri" do 
		service = RedirectorService.new({ url: "http://www.google.com" })
		salt = service.send(:generate_salt)
		expect(salt).to match(/[a-z0-9]{10}/i)
	end

	it "successfully generates short url for the uri" do 
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

	it "returns correct stats" do 
		short_url = RedirectorService.new({ url: "http://www.google.com" }).create[:short_url]
		url = RedirectorService.new({short_url: short_url}).redirect[:url]
		counter = RedirectorService.new({short_url: short_url}).stats[:counter]
		expect(counter).to match(1)
	end

	it "fails to create short url when bad uri provided" do 
		errors = RedirectorService.new({ url: "bad uri" }).create
		expect(errors).to match({ errors: 'Incorrect URL' })	
	end

	it "fails to redirect when non-existing short url provided" do 
		errors = RedirectorService.new({ short_url: "non-existing-short-url" }).redirect
		expect(errors).to match({ errors: 'Record not found' })	
	end

	it "fails to provide the stats for non-existing short url" do 
		errors = RedirectorService.new({ short_url: "non-existing-short-url" }).stats
		expect(errors).to match({ errors: 'Record not found' })	
	end
end