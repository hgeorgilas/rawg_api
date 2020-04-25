module RawgApi
  module Entities
    class Game
      class Series < Entities::BaseEntity
        client_service Clients::Games::Series

        attr_entity :id, :slug, :name, :released, :tba, :background_image, :rating, :rating_top,
                    :ratings, :ratings_count, :reviews_text_count, :added, :added_by_status,
                    :metacritic, :playtime, :suggestions_count
      end
    end
  end
end
