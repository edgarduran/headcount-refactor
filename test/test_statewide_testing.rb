require 'district_repository'
require 'pry'
require 'district'
require 'statewide_testing'

class TestStatewideTesting < Minitest::Test

  def test_proficient_by_grade
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected   = {2008=>0.671, 2009=>0.706, 2010=>0.662, 2011=>0.678, 2012=>0.655, 2013=>0.668, 2014=>0.639}
    assert_equal expected, district.statewide_testing.proficient_by_grade(3)
  end

  def test_proficient_by_race_or_ethnicity(race_input)
    skip
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected   = {2008=>0.671, 2009=>0.706, 2010=>0.662, 2011=>0.678, 2012=>0.655, 2013=>0.668, 2014=>0.639}
    assert_equal expected, district.proficient_by_race_or_ethnicity(race_input)
  end

  def test_proficient_for_subject_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected   = 0.713
    assert_equal expected, district.statewide_testing.proficient_for_subject_in_year(:math, 2012)
  end
end
