module RawgApi
  module Entities
    class Game
      class Entity < BaseEntity

        delegate_method Game::Additions, :find_additions, :find
        delegate_method Game::YouTube, :find_youtube, :find
        delegate_method Game::Twitch, :find_twitch, :find
        delegate_method Game::SuggestedGames, :find_suggested_games, :find
        delegate_method Game::Series, :find_series, :find
        delegate_method Game::Screenshots, :find_screenshots, :find
        delegate_method Game::Stores, :find_stores, :find
        delegate_method Game::Reddit, :find_reddit, :find
        delegate_method Game::Details, :find, :find

        client_service Clients::Games

        attr_entity :id, :slug, :name, :released, :tba, :background_image, :rating, :rating_top,
                    :ratings, :ratings_count, :reviews_text_count, :added, :added_by_status,
                    :metacritic, :playtime, :suggestions_count

      end
    end
  end
end