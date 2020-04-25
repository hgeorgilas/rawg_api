require_relative 'version'
require 'dotenv/load'
require 'api_struct'
require_relative "configuration"
if ENV.fetch('ENVIRONMENT', 'production') == 'development'
  require 'pry'
  require 'httplog'
end
ENTITIES_LOAD_ORDER = %w(
entities/game/additions
entities/game/suggested_games
entities/game/stores
entities/game/development_team
entities/game/series
entities/game/trailers
entities/game/twitch
entities/game/parent_games
entities/game/youtube
entities/game/screenshots
entities/game/reddit
entities/game/achievements
entities/game/details
entities/game/entity
entities/developer
entities/creator
entities/base_entity
entities/creator_role
entities/genre
entities/platform
entities/publisher
entities/store
entities/tag_details
entities/tag)

Dir[File.join(__dir__, 'extensions', '*.rb')].each { |f| require_relative  f }
require_relative "clients/base_client"
Dir[File.join(__dir__,  'clients', '**', '*.rb')].each { |f| require_relative  f }
require_relative "entities/base_entity"
ENTITIES_LOAD_ORDER.each { |f| require_relative "#{f}.rb" }
