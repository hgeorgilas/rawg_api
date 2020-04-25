module RawgApi
  module Entities
    class Game
      class DevelopmentTeam < Entities::BaseEntity
        client_service Clients::Games::DevelopmentTeam

        attr_entity :id, :name, :slug, :image, :image_background, :games_count
      end
    end
  end
end
