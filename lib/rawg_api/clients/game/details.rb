module RawgApi
  module Clients
    class Games
      class Details < Clients::BaseClient
        rawg_api :games

        def find(id)
          get(id)
        end

      end
    end
  end
end