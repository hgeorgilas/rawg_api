module RawgApi
  module Entities
    class Game
      class Trailers < Entities::BaseEntity
        client_service Clients::Games::Trailers

        attr_entity :id, :name, :preview, :data
      end
    end
  end
end
