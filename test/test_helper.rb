$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "minitest/autorun"
require "rawg_api"
require 'rubygems'
require 'vcr'
require 'webmock/minitest'

VCR.configure do |config|
  config.cassette_library_dir = "test/fixtures/vcr_cassettes"
  config.hook_into :webmock
end