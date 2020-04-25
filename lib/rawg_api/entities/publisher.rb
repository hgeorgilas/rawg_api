module RawgApi
  module Entities
    class Publisher < BaseEntity
      client_service Clients::Publishers

      attr_entity :id, :name, :slug, :games_count, :image_background
    end
  end
end
