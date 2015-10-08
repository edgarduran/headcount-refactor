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

  def test_kindergarten_participation_by_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("Colorado")
    expected = {2007=>0.394, 2006=>0.336, 2005=>0.278, 2004=>0.24, 2008=>0.535,
                2009=>0.598, 2010=>0.64, 2011=>0.672, 2012=>0.695, 2013=>0.702,
                2014=>0.741}
    assert_equal expected, district.enrollment.kindergarten_participation_by_year
  end

  def test_unknown_years_return_nil_for_kinder
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_equal nil, district.enrollment.kindergarten_participation_in_year(232323322332)
  end

  def test_kindergarten_participation_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("Colorado")
    assert_equal 0.64, district.enrollment.kindergarten_participation_in_year(2010)
  end

  def test_unknown_years_return_nil_online
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_equal nil, district.enrollment.online_participation_in_year(232323322332)
  end

  def test_online_participation_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_equal 341, district.enrollment.online_participation_in_year(2013)
  end

  def test_participation
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected = {2009=>22620, 2010=>23119, 2011=>23657, 2012=>23973, 2013=>24481, 2014=>24578}
    assert_equal expected, district.enrollment.participation_by_year
  end

  def test_unknown_years_return_nil_participate
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_equal nil, district.enrollment.participation_in_year(232323322332)
  end

  def test_participation_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_equal 22620, district.enrollment.participation_in_year(2009)
  end

  def test_special_education_by_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected = { 2009 => 0.075, 2010 => 0.078, 2011 => 0.079, 2012 => 0.078,
                 2013 => 0.079, 2014 => 0.079}
    assert_equal expected, district.enrollment.special_education_by_year
  end


  def test_unknown_years_return_nil_special_ed_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_equal nil, district.enrollment.special_education_in_year(232323322332)
  end

  def test_special_ed_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_equal 0.079, district.enrollment.special_education_in_year(2013)
  end

  def test_remediation_by_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected = { 2009 => 0.264, 2010 => 0.294, 2011 => 0.263,}
    assert_equal expected, district.enrollment.remediation_by_year
  end

  def test_unknown_years_return_nil_remediation
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_equal nil, district.enrollment.remediation_in_year(232323322332)
  end

  def test_remediation_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_equal 0.294, district.enrollment.remediation_in_year(2010)
  end

end

h = {:location=>"ACADEMY 20", :category=>"All Students", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.002"}
h[:category]
