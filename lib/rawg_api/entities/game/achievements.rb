module RawgApi
  module Entities
    class Game
      class Achievements < Entities::BaseEntity
        client_service Clients::Games::Achievements

        attr_entity :id, :name, :description, :image, :percent
      end
    end
  end
end