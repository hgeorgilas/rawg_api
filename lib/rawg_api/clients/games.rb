module RawgApi
  module Clients
    class Games < BaseClient
      rawg_api :games

      def all(page: 1, page_size: DEFAULT_PAGE_SIZE)
        get(params: {page: page, page_size: page_size})
      end

      def search(page: 1, page_size: DEFAULT_PAGE_SIZE, title: nil, exclude_collection: nil,
                 exclude_parents: nil, exclude_game_series: nil, order: nil,
                 parent_platforms: [], platforms: [], stores: [], developers: [],
                 publishers: [], genres: [], tags: [], creators: [], dates: [],
                 platforms_count: [])

        search_params = build_search_params(binding)
        get(params: search_params)
      end

      private

      def build_search_params(m_binding)
        params = key_params_to_hash(m_binding)
        params.map { |k, v| [transform_key(k), transform_value(k, v)] }.to_h
      end

      def values_transformer
        @values_transformer ||= {
            parent_platforms: array_join_transformer,
            platforms: array_join_transformer,
            stores: array_join_transformer,
            developers: array_join_transformer,
            publishers: array_join_transformer,
            genres: array_join_transformer,
            tags: array_join_transformer,
            creators: array_join_transformer,
            dates: array_join_transformer,
            platforms_count: array_join_transformer
        }
      end

      def keys_transformer
        @keys_transformer ||= {
            title: :search,
            order: :ordering
        }
      end

    end
  end
end