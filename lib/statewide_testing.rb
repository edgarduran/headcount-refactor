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
    if grade == 3
      csv_file = THIRD_GRADE
    elsif grade == 8
      csv_file = EIGHTH_GRADE
    end
    parsed = send_to_parser(csv_file)
    data = parsed.select { |row| row if row.fetch(:dataformat) == "Percent" }
    time = data.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
  end

  def proficient_by_race_or_ethnicity(race_input)
    raise UnknownDataError unless valid_races?(race_input)
    parsed_math    = send_to_parser(MATH)
    parsed_reading = send_to_parser(READING)
    parsed_writing = send_to_parser(WRITING)

  end

  def proficient_for_subject_in_year(subject, year)
    if subject    == :math
      csv_file    = MATH
   elsif subject  == :reading
      csv_file    = READING
   elsif subject  == :writing
      csv_file    = WRITING
    end
    parsed = send_to_parser(csv_file)
    data = parsed.select { |row| row if row.fetch(:dataformat) == "Percent" }
    time = data.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
    time.fetch(year)
  end

  def valid_grades?(grade)
    [3, 8]
  end

  def valid_races?(race)
    ["asian", "black", "pacific Islander", "hispanic",
     "native american", "two or more", "white"]
  end

  class UnknownDataError < StandardError
    "Data Error"
  end

end
