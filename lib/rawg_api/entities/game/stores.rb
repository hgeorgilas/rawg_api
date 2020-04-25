module RawgApi
  module Entities
    class Game
      class Stores < Entities::BaseEntity
        client_service Clients::Games::Stores

        attr_entity :id, :game_id, :store_id, :url
      end
    end
  end
end