# frozen_string_literal: true

require 'securerandom'
require 'digest'
require 'uri'

class RedirectorService
  attr_accessor :url, :short_url

  RECORD_NOT_FOUND_ERROR = 'Record not found'

  def initialize(params)
    @url = params[:url]
    @short_url = params[:short_url]
  end

  def create
    return { errors: 'Incorrect URL' } unless correct_url?

    record = Url.create(url: url, short_url: generate_short_url)

    if record.errors.empty?
      { short_url: record.short_url }
    else
      { errors: record.errors.messages }
    end
  end

  def redirect
    record = Url.where(short_url: short_url).first

    if record
      record.counter += 1
      record.save

      { url: record.url }
    else
      { errors: RECORD_NOT_FOUND_ERROR }
    end
  end

  def stats
    record = Url.where(short_url: short_url).first

    if record
      { counter: record.counter }
    else
      { errors: RECORD_NOT_FOUND_ERROR }
    end
  end

  private

  def generate_short_url
    digest = Digest::MD5.hexdigest(url + generate_salt)
    short_url = digest[0, 5]

    return generate_short_url if short_url_exist?

    short_url
  end

  def generate_salt
    SecureRandom.alphanumeric(10)
  end

  def short_url_exist?
    Url.where(short_url: short_url).first
  end

  def correct_url?
    url =~ URI::DEFAULT_PARSER.make_regexp ? true : false
  end
end
