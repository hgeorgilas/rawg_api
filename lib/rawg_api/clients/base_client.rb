module RawgApi
  module Clients
    class BaseClient < ::ApiStruct::Client

      DEFAULT_PAGE_SIZE = RawgApi.configuration.page_size

      private

      def transform_key(key)
        keys_transformer.dig(key) || key
      end

      def transform_value(key, value)
        return value unless self.respond_to?(:transformer_) && values_transformer.key?(key)
        value.public_send(values_transformer[key][:method], *values_transformer[key][:args])
      end

      def key_params_to_hash(m_binding)
        m_binding.local_variables.map { |x| [x, m_binding.local_variable_get(x)] }.to_h.compact
      end

      def array_join_transformer(delimiter: ',')
        {
            method: :join,
            args: [delimiter]
        }
      end

    end
  end
end
