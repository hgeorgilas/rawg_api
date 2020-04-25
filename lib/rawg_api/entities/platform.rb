module RawgApi
  module Entities
    class Platform < BaseEntity
      client_service Clients::Platforms

      attr_entity :id, :name, :slug, :games_count, :image_background, :image, :year_start, :year_end
    end
  end
end
