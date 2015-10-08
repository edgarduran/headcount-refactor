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

  def test_graduation_rates_by_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected = {2010 => 0.895, 2011 => 0.895, 2012 => 0.889, 2013 => 0.913, 2014 => 0.898}
    assert_equal expected, district.enrollment.graduation_rate_by_year
  end

  def test_graduation_rates_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_equal 0.895, district.enrollment.graduation_rate_in_year(2010)
  end

  def test_unknown_years_return_nil
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("Colorado")
    assert_equal nil, district.enrollment.graduation_rate_in_year(232323322332)
  end

  def test_returns_a_hash_of_years_to_truncated_kindergarten_participation_percentages
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("Colorado")
    expected = {2007=>0.394, 2006=>0.336, 2005=>0.278, 2004=>0.24, 2008=>0.535,
                2009=>0.598, 2010=>0.64, 2011=>0.672, 2012=>0.695, 2013=>0.702,
                2014=>0.741}
    assert_equal expected, district.enrollment.kindergarten_participation_by_year
  end

  def test_unknown_years_return_nil
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_equal nil, district.enrollment.kindergarten_participation_in_year(232323322332)
  end

  def kindergarten_participation_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("Colorado")
    binding.pry 
    assert_equal 0.436, district.enrollment.kindergarten_participation_in_year(2010)
  end

end
