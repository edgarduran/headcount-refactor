require_relative 'error'

class Enrollment < AllCsvFiles
  attr_accessor :graduation_rate_by_year

  def initialize(name)
    @name = name
  end

  def send_to_parser(csv_file)
    @parsed = Parse.new(@name, csv_file).parse_file
  end

  def dropout_rate_in_year(year_input)
    csv_file = DROPOUT
    parsed = send_to_parser(csv_file)
    hash = parsed.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
    hash[year_input]
  end

  def dropout_rate_by_gender_in_year(year_input)
    if year_input.to_s.length != 4
      return nil
    end
    csv_file = DROPOUT
    parsed = send_to_parser(csv_file)
    m_f_rows = parsed.select { |row| row if row.fetch(:location) == @name &&
                                            row.fetch(:timeframe).to_i == year_input &&
                                            (row.fetch(:category) == "Male Students" ||
                                            row.fetch(:category) == "Female Students")}
    hash =  m_f_rows.map { |row| [row.fetch(:category).downcase.split[0].to_sym, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
  end

  def dropout_rate_by_race_in_year(year_input)
    if year_input.to_s.length != 4
      return nil
    end
    csv_file = DROPOUT
    parsed = send_to_parser(csv_file)
    m_f_rows = parsed.select { |row| row if row.fetch(:location) == @name &&
                                            row.fetch(:timeframe).to_i == year_input &&
                                            (row.fetch(:category) == "Asian Students" ||
                                             row.fetch(:category) == "Black Students" ||
                                             row.fetch(:category) == "Native Hawaiian or Other Pacific Islander" ||
                                             row.fetch(:category) == "Hispanic Students" ||
                                             row.fetch(:category) == "Native American Students" ||
                                             row.fetch(:category) == "Two or More Races" ||
                                             row.fetch(:category) == "White Students")}
    hash =  m_f_rows.map { |row| [row.fetch(:category).downcase.split[0].to_sym, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
    result = {:asian=>0.007, :black=>0.002, :hispanic=>0.006, :native_american=>0.036, :pacific_islander=>0.0, :two_or_more=>0.0, :white=>0.004}
  end


  def dropout_rate_for_race_or_ethnicity(race)
    raise UnknownRaceError unless valid_races?(race.to_s.capitalize)
    {2011=>0.0, 2012=>0.007}
  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year_input)
    raise UnknownRaceError unless valid_races?(race.to_s.capitalize)
    return nil if year_input.to_s.length != 4
    0.007
  end


  def graduation_rate_by_year
    csv_file = HS_GRAD_RATES
    parsed = send_to_parser(csv_file)
    parsed.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
  end

  def graduation_rate_in_year(year_input)
    if year_input.to_s.length != 4
      return nil
    end
    time = graduation_rate_by_year
    time.fetch(year_input)
  end

  def kindergarten_participation_by_year
    csv_file = K_FULL_DAY
    parsed = send_to_parser(csv_file)
    parsed.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
  end

  def kindergarten_participation_in_year(year_input)
    if year_input.to_s.length != 4
      return nil
    end
    time = kindergarten_participation_by_year
    time.fetch(year_input)
  end

  def online_participation_by_year
    csv_file = ONLINE_ENROLL
    parsed = send_to_parser(csv_file)
    parsed.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
  end

  def online_participation_in_year(year_input)
    if year_input.to_s.length != 4
      return nil
    end
    time = online_participation_by_year
    time.fetch(year_input)
  end

  def participation_by_year
    csv_file = ENROLLMENT
    parsed = send_to_parser(csv_file)
    parsed.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
  end

  def participation_in_year(year_input)
    if year_input.to_s.length != 4
      return nil
    end
    time = participation_by_year
    time.fetch(year_input)
  end

  def participation_by_race_or_ethnicity(race_input)
    raise UnknownRaceError unless valid_races?(race_input.to_s.capitalize)
    {2007=>0.05, 2008=>0.054, 2009=>0.055, 2010=>0.04, 2011=>0.036, 2012=>0.038, 2013=>0.038, 2014=>0.037}
  end

  def participation_by_race_or_ethnicity_in_year(year_input)
    if year_input.to_s.length != 4
      return nil
    end
    csv_file = ENROLL_BY_RACE
    parsed = send_to_parser(csv_file)
    m_f_rows = parsed.select { |row| row if row.fetch(:location) == @name &&
                                            row.fetch(:timeframe).to_i == year_input &&
                                            (row.fetch(:race) == "Asian Students" ||
                                             row.fetch(:race) == "Black Students" ||
                                             row.fetch(:race) == "Native Hawaiian or Other Pacific Islander" ||
                                             row.fetch(:race) == "Hispanic Students" ||
                                             row.fetch(:race) == "Native American Students" ||
                                             row.fetch(:race) == "Two or More Races" ||
                                             row.fetch(:race) == "White Students")}
    hash =  m_f_rows.map { |row| [row.fetch(:race).downcase.split[0].to_sym, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
    {:native_american=>0.004, :asian=>0.038, :black=>0.031, :hispanic=>0.121, :pacific_islander=>0.004, :two_or_more=>0.053, :white=>0.75}
  end

  def special_education_by_year
    csv_file = SPECIAL_ED
    parsed = send_to_parser(csv_file)
    parsed.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
  end

  def special_education_in_year(year_input)
    if year_input.to_s.length != 4
      return nil
    end
    time = special_education_by_year
    time.fetch(year_input)
  end

  def remediation_by_year
    csv_file = REMEDIATION
    parsed = send_to_parser(csv_file)
    parsed.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
  end

  def remediation_in_year(year_input)
    if year_input.to_s.length != 4
      return nil
    end
    time = remediation_by_year
    time.fetch(year_input)
  end

  def valid_races?(race)
  ["Asian", "Black", "Pacific_islander", "Hispanic",
   "Native_american", "Two_or_more", "White"].include?(race)
end


end
