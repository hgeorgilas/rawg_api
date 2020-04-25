module RawgApi
  module Entities
    class Game
      class SuggestedGames < Entities::BaseEntity
        client_service Clients::Games::SuggestedGames

        attr_entity :id
      end
    end
  end
end