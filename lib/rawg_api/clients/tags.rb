module RawgApi
  module Clients
    class Tags < BaseClient
      rawg_api :tags

      def all(page: 1, page_size: DEFAULT_PAGE_SIZE)
        get(params: {page: page, page_size: page_size})
      end

    end
  end
end