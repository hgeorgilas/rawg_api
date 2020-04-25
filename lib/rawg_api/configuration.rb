module RawgApi

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    DEFAULT_API_ENDPOINT = 'https://api.rawg.io/api'
    DEFAULT_APP_NAME = 'Rawg.io Ruby Client (rawg_api)'
    DEFAULT_PAGE_SIZE = 50

    attr_accessor :endpoint, :app_name, :headers, :page_size

    def initialize
      @endpoint ||= DEFAULT_API_ENDPOINT
      @app_name ||= DEFAULT_APP_NAME
      @page_size ||= DEFAULT_PAGE_SIZE
      ::ApiStruct::Settings.configure do |config|
        config.endpoints = build_config[:endpoints]
      end
    end

    def build_config
      {
          endpoints: {
              rawg_api: {
                  root: @endpoint,
                  headers: api_headers
              }
          }
      }
    end

    def api_headers
      (headers || {}).merge({'User-Agent': @app_name})
    end

  end
end

RawgApi.configure do |config|
end