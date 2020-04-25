require_relative '../extensions/dry_monads'
module RawgApi
  module Entities
    EntityResponse = Struct.new(:metadata, :results)

    # Workaround to silence Hashie warnings logger
    class BaseEntityHashie < Hashie::Mash
      disable_warnings
    end

    class BaseEntity < ::ApiStruct::Entity
      extend RawgApi::Extensions::DryMonads

      class << self
        attr_accessor :delegated_methods

        def delegate_method(resolver_klass = nil, *args)
          define_method = args[0].to_sym
          call_method = args[1].to_sym
          define_singleton_method(define_method) do |*attrs|
            id = attrs.shift
            args = attrs.shift || {}
            if args.empty?
              resolver_klass.send(call_method, id)
            else
              resolver_klass.send(call_method, id, **args)
            end
          end
          self.delegated_methods ||= {}
          self.delegated_methods[define_method] = {class: resolver_klass, method: call_method}
        end

        def collection(entities, entity_type = self)
          if !entities.is_a?(Array) && entities.key?(:results)
            metadata = entities.dup
            metadata.delete(:results)
            results = ::ApiStruct::Collection.new(entities[:results], entity_type)
            EntityResponse.new(metadata, results)
          else
            ::ApiStruct::Collection.new(entities, entity_type)
          end
        end
      end

      def initialize(entity, entity_status = true)
        raise EntityError, "#{entity} must be Hash" unless entity.is_a?(Hash)
        @entity = BaseEntityHashie.new(extract_attributes(entity))
        @entity_status = entity_status
        __setobj__(@entity)
      end

    end
  end
end
