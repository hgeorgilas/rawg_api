module RawgApi
  module Entities
    class Game
      class Details < BaseEntity
        client_service Clients::Games::Details

        attr_entity :id, :slug, :name, :name_original, :description, :metacritic, :released, :tba,
                    :updated, :background_image, :background_image_additional, :website, :rating,
                    :rating_top, :ratings, :reactions, :added, :added_by_status, :playtime, :screenshots_count,
                    :movies_count, :creators_count, :achievements_count, :parent_achievements_count, :reddit_url,
                    :reddit_name, :reddit_description, :reddit_logo, :reddit_count, :twitch_count, :youtube_count,
                    :reviews_text_count, :ratings_count, :suggestions_count, :alternative_names, :metacritic_url,
                    :parents_count, :additions_count, :game_series_count, :user_game, :reviews_count, :saturated_color,
                    :dominant_color, :parent_platforms, :platforms, :stores, :developers, :genres, :tags, :publishers,
                    :esrb_rating, :clip, :description_raw

      end
    end
  end
end
