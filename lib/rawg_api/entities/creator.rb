module RawgApi
  module Entities
    class Creator < BaseEntity
      client_service Clients::Creators

      attr_entity :id, :name, :slug, :image, :image_background, :games_count
    end
  end
end