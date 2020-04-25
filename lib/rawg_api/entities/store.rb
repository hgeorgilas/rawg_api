module RawgApi
  module Entities
    class Store < BaseEntity
      client_service Clients::Stores

      attr_entity :id, :name, :domain, :slug, :games_count, :image_background
    end
  end
end
