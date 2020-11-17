require 'rails_helper'

RSpec.describe RedirectorService do
	it "successfully generate salt for the uri" do 
		service = RedirectorService.new({ url: "http://www.google.com" })
		salt = service.send(:generate_salt)
		expect(salt.length).to eq(10)
		expect(salt).to match(/[a-z0-9]{10}/i)
	end
end