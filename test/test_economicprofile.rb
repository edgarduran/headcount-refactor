require 'district_repository'
require 'district'
require 'economic_profile'

class Testeconomic_profile < Minitest::Test

  def test_free_or_reduced_lunch_by_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected = {2014=>0.127, 2012=>0.125, 2011=>0.119, 2010=>0.113, 2009=>0.103, 2013=>0.131, 2008=>0.093, 2007=>0.08, 2006=>0.072, 2005=>0.058, 2004=>0.059, 2003=>0.06, 2002=>0.048, 2001=>0.047, 2000=>0.04}
    assert_equal expected, district.economic_profile.free_or_reduced_lunch_by_year
  end

  def test_free_or_reduced_lunch_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected   = 0.113
    assert_equal expected, district.economic_profile.free_or_reduced_lunch_in_year(2010)
  end

  def test_free_or_reduced_lunch_in_year_unknown_error
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_raises (UnknownDataError::StandardError) { economic_profile.free_or_reduced_lunch_in_year(20123) }
  end

  def test_school_aged_children_in_poverty_by_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected   = {1995=>0.032, 1997=>0.035, 1999=>0.032, 2000=>0.031, 2001=>0.029, 2002=>0.033, 2003=>0.037, 2004=>0.034, 2005=>0.042, 2006=>0.036, 2007=>0.039, 2008=>0.044, 2009=>0.047, 2010=>0.057, 2011=>0.059, 2012=>0.064, 2013=>0.048}
    assert_equal expected, district.economic_profile.school_aged_children_in_poverty_by_year
  end

  def test_school_aged_children_in_poverty_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected   = 0.029
    assert_equal expected, district.economic_profile.school_aged_children_in_poverty_in_year(2001)
  end

  def test_school_aged_children_in_poverty_in_year_unknown_error
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_raises (UnknownDataError::StandardError) { economic_profile.school_aged_children_in_poverty_in_year(32123) }
  end

  def test_title_1_students_by_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected   = {2009=>0.014, 2011=>0.011, 2012=>0.01, 2013=>0.012, 2014=>0.027}
    assert_equal expected, district.economic_profile.title_1_students_by_year
  end

  def test_title_1_students_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected   = 0.014
    assert_equal expected, district.economic_profile.title_1_students_in_year(2009)
  end

  def test_title_1_students_in_year_unknown_error
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_raises (UnknownDataError::StandardError) { economic_profile.title_1_students_in_year(32123) }
  end

end
