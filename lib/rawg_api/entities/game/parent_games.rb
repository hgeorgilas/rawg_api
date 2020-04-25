module RawgApi
  module Entities
    class Game
      class ParentGames < Entities::BaseEntity
        client_service Clients::Games::ParentGames

        attr_entity :id, :slug, :name, :released, :tba, :background_image, :rating, :rating_top, :ratings,
                    :ratings_count, :reviews_text_count, :added, :added_by_status,
                    :metacritic, :playtime, :suggestions_count
      end
    end
  end
end
