module RawgApi
  module Entities
    class Game
      class YouTube < Entities::BaseEntity
        client_service Clients::Games::Youtube

        attr_entity :id, :external_id, :channel_id, :channel_title, :name, :description,
                    :created, :view_count, :comments_count, :like_count, :dislike_count,
                    :favorite_count, :thumbnails
      end
    end
  end
end
