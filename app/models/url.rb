# frozen_string_literal: true

class Url < ApplicationRecord
  validates :url, presence: true
  validates :short_url, presence: true, uniqueness: true
end