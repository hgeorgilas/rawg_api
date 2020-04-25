module RawgApi
  module Entities
    class Developer < BaseEntity
      client_service Clients::Developers

      attr_entity :id, :name, :slug, :games_count, :image_background
    end
  end
end