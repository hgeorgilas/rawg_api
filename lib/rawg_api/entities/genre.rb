module RawgApi
  module Entities
    class Genres < BaseEntity
      client_service Clients::Genres

      attr_entity :id, :name, :slug, :games_count, :image_background
    end
  end
end
