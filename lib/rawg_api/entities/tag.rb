module RawgApi
  module Entities
    class Tag < BaseEntity
      client_service Clients::Tags

      delegate_method TagDetails, :find, :find

      attr_entity :id, :name, :slug, :games_count, :image_background
    end
  end
end
