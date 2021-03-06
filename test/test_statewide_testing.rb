require 'district_repository'
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

  def test_proficient_by_grade
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("AGATE 300")
    expected   = {2008=>{:writing=>0.29}, 2009=>{:writing=>0.29}}
    assert_equal expected, district.statewide_testing.proficient_by_grade(3)
  end

  def test_proficient_by_grade_unknown_error
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_raises (UnknownDataError::StandardError) { statewide_testing.proficient_by_grade(2) }
  end

  def test_proficient_by_race_or_ethnicity
    skip
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected   = {2008=>0.671, 2009=>0.706, 2010=>0.662, 2011=>0.678, 2012=>0.655, 2013=>0.668, 2014=>0.639}
    assert_equal expected, district.statewide_testing.proficient_by_race_or_ethnicity(:white)
  end

  def test_proficient_for_race_or_ethnicity_unkown_error
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_raises (UnknownDataError::StandardError) { statewide_testing.proficient_by_race_or_ethnicity(mexicali) }
  end

  def test_proficient_for_subject_by_grade_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected   = 0.83
    assert_equal expected, district.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2012)
  end

  def test_proficient_for_subject_by_grade_in_year_unkown_error
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_raises (UnknownDataError::StandardError) { statewide_testing.proficient_for_subject_by_grade_in_year(:science, 3, 2012) }
  end

  def test_proficient_for_subject_by_race_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected   = 0.818
    assert_equal expected, district.statewide_testing.proficient_for_subject_by_race_in_year(:math, :asian, 2012)
  end

  def test_proficient_for_subject_by_race_in_year_unkown_error
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_raises (UnknownDataError::StandardError) { statewide_testing.proficient_for_subject_by_race_in_year(:history, 3, 2012) }
  end

  def test_proficient_for_subject_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    expected   = 0.713
    assert_equal expected, district.statewide_testing.proficient_for_subject_in_year(:math, 2012)
  end

  def test_proficient_for_subject_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_raises (UnknownDataError::StandardError) { statewide_testing.proficient_for_subject_in_year(:history, 2012) }
  end
end
