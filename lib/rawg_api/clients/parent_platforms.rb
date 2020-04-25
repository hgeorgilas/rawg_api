module RawgApi
  module Clients
    class ParentPlatforms < BaseClient
      rawg_api :platforms

      def all(page: 1, page_size: DEFAULT_PAGE_SIZE)
        get('lists/parents', params: {page: page, page_size: page_size})
      end
    end
  end
end