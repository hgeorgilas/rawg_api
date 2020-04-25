module RawgApi
  module Entities
    class Game
      class Screenshots < Entities::BaseEntity
        client_service Clients::Games::Screenshots

        attr_entity :image
      end
    end
  end
end
