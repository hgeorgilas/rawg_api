module RawgApi
  module Extensions
    module DryMonads

      def from_success(value)
        return Dry::Monads::Success(nil) if value.nil?
        value.is_a?(Array) || value[:results].is_a?(Array) ? collection(value) : new(value)
      end

    end
  end
end