require_relative 'test_helper'

class EntitiesTest < Minitest::Test
  def setup
    @valid_bulk_entities_methods = [:search, :all].freeze
    @valid_entity_entities_methods = [:find].freeze
    set_entities
  end

  def test_entities_bulk_methods_responses_have_correct_attributes
    @entities.each do |entity|
      methods = entity.methods.select { |m| @valid_bulk_entities_methods.include?(m) }
      client = entity.clients[:base]
      methods.each do |method|
        cassette_name = "#{client.to_s.downcase}_#{method}"
        VCR.use_cassette(cassette_name) do
          response = send_method(entity, method)
          refute_nil response.metadata
          refute_nil response.results
          assert_instance_of ApiStruct::Collection, response.results
          assert_instance_of Hash, response.metadata
          result = response_and_entity_attrs(response, entity.entity_attributes)
          assert_equal result[0], result[1]
        end
      end
    end
  end

  def test_entities_entity_methods_responses_have_correct_attributes
    @entities.each do |entity|
      methods = entity.methods.select do |m|
        @valid_entity_entities_methods.include?(m) && !delegated_method?(entity, m)
      end
      client = entity.clients[:base]
      methods.each do |method|
        cassette_name = "#{client.to_s.downcase}_#{method}"
        VCR.use_cassette(cassette_name) do
          response = send_method(entity, method)
          result = response_and_entity_attrs(response, entity.entity_attributes)
          assert_equal result[0], result[1]
        end
      end
    end
  end

  def test_entities_entity_delegated_methods_responses_have_correct_attributes
    @entities.each do |entity|
      next unless entity.respond_to?(:delegated_methods) && entity.delegated_methods
      delegated_methods = entity.delegated_methods
      delegated_methods.each do |method, delegated_method_options|
        delegated_entity = delegated_method_options[:class]
        cassette_name = "#{entity.to_s.downcase}_#{delegated_entity.to_s.downcase}_#{method}"
        VCR.use_cassette(cassette_name) do
          response = send_method(entity, method)
          result = response_and_entity_attrs(response, delegated_entity.entity_attributes)
          assert_equal result[0], result[1]
        end
      end
    end
  end

  # Helpers

  def response_and_entity_attrs(response, attributes)
    if response.respond_to?(:results) && response.results
      return response.results.first.keys.map(&:to_sym).sort, attributes.sort
    else
      return response.keys.map(&:to_sym).sort, attributes.sort
    end
  end

  def delegated_method?(entity, method)
    return false unless entity.respond_to?(:delegated_methods) && entity.delegated_methods
    delegated_methods = entity.delegated_methods.map { |k, v| k }
    delegated_methods.include?(method.to_sym)
  end

  def sample_id(entity)
    entity = entity.to_s
    case true
    when entity == 'RawgApi::Entities::Tag'
      99 # A valid tag
    when entity.include?('Entities::Game')
      3328 # The Witcher 3
    when entity == 'RawgApi::Entities::DevelopmentTeam'
      3328 # The Witcher 3
    else
      1 # Generic id
    end
  end

  def send_method(instance, method)
    if method.to_s.include?('find')
      instance.send(method.to_sym, sample_id(instance))
    else
      instance.send(method.to_sym)
    end
  end

  def set_entities
    # Get all fully qualified class names under RawgApi::Entities & RawgApi::Entities::Game
    # minus the RawgApi::Clients::BaseEntity class
    @entities ||= include_entities - exclude_entities
  end

  def include_entities
    (RawgApi::Entities.constants.map(&RawgApi::Entities.method(:const_get)) + RawgApi::Entities::Game.constants.map(&RawgApi::Entities::Game.method(:const_get))).grep(Class)
  end

  def exclude_entities
    [
        RawgApi::Entities::BaseEntity,
        RawgApi::Entities::EntityResponse,
        RawgApi::Entities::BaseEntityHashie,
        RawgApi::Entities::Game,
        RawgApi::Entities::Game::ParentGames, # Endpoint seems to not return any data
        RawgApi::Entities::Game::Trailers # Endpoint seems to not return any data
    ]
  end

end
