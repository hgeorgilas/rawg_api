module RawgApi
  module Entities
    class Game
      class Twitch < Entities::BaseEntity
        client_service Clients::Games::Twitch

        attr_entity :id, :external_id, :name, :description, :created,
                    :published, :thumbnail, :view_count, :language
      end
    end
  end
end