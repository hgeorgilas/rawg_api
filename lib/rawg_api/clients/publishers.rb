module RawgApi
  module Clients
    class Publishers < BaseClient
      rawg_api :publishers

      def all(page: 1, page_size: DEFAULT_PAGE_SIZE)
        get(params: {page: page, page_size: page_size})
      end

      def find(id)
        get(id)
      end

    end
  end
end