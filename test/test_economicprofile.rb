require 'district_repository'
require 'pry'
require 'district'
require 'economicprofile'

class TestEconomicProfile < Minitest::Test

  def test_first
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_equal 0.895, district.economicprofile.graduation_rate_in_year(2010)
  end

  def test_second
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected = {2010 => 0.895, 2011 => 0.895, 2012 => 0.889, 2013 => 0.913, 2014 => 0.898}
    assert_equal expected, district.economicprofile.graduation_rate_by_year
  end
end
