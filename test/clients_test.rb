require_relative 'test_helper'

class ClientsTest < Minitest::Test
  def setup
    @valid_client_methods = [:find, :all].freeze
    set_clients
  end

  def test_clients_find_and_all_method_respond_success
    @clients.each do |client|
      instance = client.new
      methods = instance.methods.select { |m| @valid_client_methods.include?(m) }
      methods.each do |method|
        cassette_name = "#{client.to_s.downcase}_#{method}"
        VCR.use_cassette(cassette_name) do
          response = send_request_method(instance, method)
          assert_equal response.success?, true
        end
      end
    end
  end

  def test_clients_find_and_all_methods_respond_array
    @clients.each do |client|
      instance = client.new
      method = instance.methods.select { |m| m == :all }.first
      next unless method
      cassette_name = "#{client.to_s.downcase}_#{method}"
      VCR.use_cassette(cassette_name) do
        response = send_request_method(instance, method)
        assert_instance_of Array, response.value![:results]
      end
    end
  end

  # Helpers
  def send_request_method(instance, method)
    if method == :find
      instance.send(method.to_sym, sample_id(instance))
    else
      instance.send(method.to_sym)
    end
  end

  def set_clients
    @clients ||=
        begin
          # Get all fully qualified class names under RawgApi::Clients & RawgApi::Clients::Games
          # minus the RawgApi::Clients::BaseClient class
          (RawgApi::Clients.constants.map(&RawgApi::Clients.method(:const_get)) +
              RawgApi::Clients::Games.constants.map(&RawgApi::Clients::Games.method(:const_get)))
              .grep(Class) - [RawgApi::Clients::BaseClient]
        end
  end

  def sample_id(entity)
    entity = entity.to_s
    case true
    when entity == 'RawgApi::Clients::Tags'
      99 # A valid tag
    when entity.include?('Clients::Game')
      3328 # The Witcher 3
    else
      1 # Generic id
    end
  end
end
