require "error"
require 'pry'

class StatewideTesting < AllCsvFiles
  attr_accessor :graduation_rate_by_year

  def initialize(name)
    @name = name
  end

  def send_to_parser(csv_file)
    @parsed = Parse.new(@name, csv_file).parse_file
  end

  def proficient_by_grade(grade)
    raise UnknownDataError unless valid_grades?(grade)
    csv_file = get_csv_from_grade(grade)
    parsed = send_to_parser(csv_file)
    data = parsed.select { |row| row if row.fetch(:dataformat) == "Percent" }
    good_data = data.reject {|row| row.has_value?("LNE") || row.has_value?("#VALUE!") || row.has_value?("N/A") || row.has_value?(nil)}
    time = good_data.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
  end

  def proficient_by_race_or_ethnicity(race_input)
    raise UnknownDataError unless valid_races?(race_input.to_s)
    parsed_math    = send_to_parser(MATH)
    parsed_reading = send_to_parser(READING)
    parsed_writing = send_to_parser(WRITING)
    data = parsed_math.select { |row| row if row.fetch(:dataformat) == "Percent" }
    time = data.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    raise UnknownDataError unless valid_subjects?(subject.to_s)
    csv_file = get_csv_from_grade(grade)
    parsed = send_to_parser(csv_file)
    data = parsed.select { |row| row if row.fetch(:score) == subject.to_s.capitalize && row.fetch(:dataformat) == "Percent" }
    time = data.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
    time.fetch(year)
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    raise UnknownDataError unless valid_subjects?(subject.to_s)
    csv_file = get_csv_from_subject(subject)
    parsed = send_to_parser(csv_file)
    data = parsed.select { |row| row if row.fetch(:dataformat) == "Percent" && row.fetch(:race_ethnicity) == race.to_s.capitalize }
    time = data.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
    time.fetch(year)
  end

  def proficient_for_subject_in_year(subject, year)
    raise UnknownDataError unless valid_subjects?(subject.to_s)
    csv_file = get_csv_from_subject(subject)
    parsed = send_to_parser(csv_file)
    data = parsed.select { |row| row if row.fetch(:dataformat) == "Percent" }
    time = data.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
    time.fetch(year)
  end

  def get_csv_from_grade(grade)
    if grade == 3
      csv_file = THIRD_GRADE
    elsif grade == 8
      csv_file = EIGHTH_GRADE
    end
  end

  def get_csv_from_subject(subject)
    if subject     == :math
      csv_file     = MATH
    elsif subject  == :reading
      csv_file     = READING
    elsif subject  == :writing
      csv_file     = WRITING
    end
  end

  def valid_grades?(grade)
    [3, 8].include?(grade)
  end

  def valid_races?(race)
    ["asian", "black", "pacific Islander", "hispanic",
     "native american", "two or more", "white"].include?(race)
  end

  def valid_subjects?(subject)
    ["math", "reading", "writing"].include?(subject)
  end

end
