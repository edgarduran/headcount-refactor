class EconomicProfile < AllCsvFiles
  attr_accessor :graduation_rate_by_year

  def initialize(name)
    @name = name
  end

  def send_to_parser(csv_file)
    @parsed = Parse.new(@name, csv_file).parse_file
  end

  def free_or_reduced_lunch_by_year
    csv_file = REDUCED_LUNCH
    parsed = send_to_parser(csv_file)
    data = parsed.select { |row| row if row.fetch(:dataformat) == "Percent" &&
                                        row.fetch(:poverty_level) == "Eligible for Free or Reduced Lunch" }
    time = data.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
  end

  def free_or_reduced_lunch_in_year(year)
    free_or_reduced_lunch_by_year.fetch(year)
  end

  def school_aged_children_in_poverty_by_year
    csv_file = POVERTY
    parsed = send_to_parser(csv_file)
    data = parsed.select { |row| row if row.fetch(:dataformat) == "Percent" }
    time = data.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
  end

  def school_aged_children_in_poverty_in_year(year)
    school_aged_children_in_poverty_by_year.fetch(year)
  end

  def title_1_students_by_year
    csv_file = TITLE_1
    parsed = send_to_parser(csv_file)
    data = parsed.select { |row| row if row.fetch(:dataformat) == "Percent" }
    time = data.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
  end

  def title_1_students_in_year(year)
    title_1_students_by_year.fetch(year)
  end

  def graduation_rate_by_year
    csv_file = HS_GRAD_RATES
    parsed = send_to_parser(csv_file)
    parsed.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
  end

  def graduation_rate_in_year(year)
    time = graduation_rate_by_year
    time.fetch(year)
  end
end
