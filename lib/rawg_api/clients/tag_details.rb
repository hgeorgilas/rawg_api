module RawgApi
  module Clients
    class TagDetails < BaseClient
      rawg_api :tags

      def find(id)
        get(id)
      end

    end
  end
end