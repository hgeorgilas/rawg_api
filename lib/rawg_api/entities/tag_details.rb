module RawgApi
  module Entities
    class TagDetails < BaseEntity
      client_service Clients::TagDetails

      attr_entity :id, :name, :slug, :games_count, :image_background
    end
  end
end
