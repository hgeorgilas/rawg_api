module RawgApi
  module Entities
    class Game
      class Reddit < Entities::BaseEntity
        client_service Clients::Games::Reddit

        attr_entity :id, :name, :text, :image, :url, :username, :username_url, :created
      end
    end
  end
end
