module RawgApi
  module Entities
    class CreatorRole < BaseEntity
      client_service Clients::CreatorRoles

      attr_entity :id, :name, :slug
    end
  end
end