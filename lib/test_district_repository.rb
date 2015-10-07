require_relative 'district_repository'
require 'pry'


class TestEnrollment < Minitest::Test

  def test_free_or_reduced_lunch_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_equal 0.895, district.enrollment.graduation_rate_in_year(2010)
  end

  def test_free_or_reduced_lunch_by_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected = {2010 => 0.895, 2011 => 0.895, 2012 => 0.889, 2013 => 0.913, 2014 => 0.898}
    assert_equal expected, district.enrollment.graduation_rate_by_year
  end

  def test_dropout_rate_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("Colorado")
    assert_equal 0.019, district.enrollment.dropout_rate_in_year(2012)
  end

  def test_dropout_rate_by_gender_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected = {:female => 0.002, :male => 0.002}
    assert_equal expected, district.enrollment.dropout_rate_by_gender_in_year(2011)
  end

end
