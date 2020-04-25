module RawgApi
  module Clients
    class CreatorRoles < BaseClient
      rawg_api :'creator-roles'

      def all(page: 1, page_size: DEFAULT_PAGE_SIZE)
        get(params: {page: page, page_size: page_size})
      end

    end
  end
end
