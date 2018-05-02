require 'faraday'
require 'faraday_middleware'
require 'json'

require "api_eventful/version"
require "api_eventful/client"

module ApiEventful
  class << self
    attr_accessor :app_key
  end

  self.app_key ||= ENV['EVENTFUL_APP_KEY']
end
