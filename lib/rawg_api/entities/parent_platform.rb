module RawgApi
  module Entities
    class ParentPlatform < BaseEntity
      client_service Clients::ParentPlatforms

      attr_entity :id, :name, :slug, :games_count, :image_background, :image, :year_start, :year_end, :platforms
    end
  end
end
