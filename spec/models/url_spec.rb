# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:short_url) }

    subject { FactoryBot.create(:url) }
    it { should validate_uniqueness_of(:short_url) }
  end
end
