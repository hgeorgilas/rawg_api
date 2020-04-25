require "test_helper"

class RawgApiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RawgApi::VERSION
  end
end
