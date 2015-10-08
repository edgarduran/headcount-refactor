require 'csv'
require 'pry'
require_relative 'all_csv_files'
require_relative 'parser'

class DistrictRepository
  def self.from_csv(path)
    filename  = "High school graduation rates.csv"
    full_path = File.join(path, filename)
    rows = CSV.readlines(full_path, headers: true, header_converters: :symbol).map(&:to_h)

    district_data =
    rows.group_by { |rows| rows.fetch(:location).upcase }.to_h
    DistrictRepository.new(district_data)
  end

  def initialize(district_data)
    @district_data = district_data
  end

  def find_by_name(name)
    name = name.upcase
    District.new(name, @district_data.fetch(name))

  end
end

class District
  def initialize(name, data)
    @name = name
    @data = data
  end

  def enrollment
    Enrollment.new(@name)
  end

end

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
    line = {}
    hash = {}
    parsed.each do |columns|
      district  = columns[:location]
      category  = columns[:category]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "ACADEMY 20"
        if year == year_input.to_s && category == "Female Students" || year == year_input.to_s && category == "Male Students"
          if category == "Female Students"
            category = category[0..5].downcase
          elsif
            category == "Male Students"
            category = category [0..3].downcase
          end
          hash = Hash[category.to_sym, (value.to_f * 1000).to_i / 1000.0]
          line = line.merge(hash)
        end
      end
    end
    return line
  end

  def dropout_rate_by_race_in_year(year_input)
    if year_input.to_s.length != 4
      return nil
    end
    data = CSV.open "#{@path}/Dropout rates by race and ethnicity.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      category  = columns[:category]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "ACADEMY 20"
        if category == "Asian Students" || category == "Black Students" || category == "Native Hawaiian or Other Pacific Islander" || category == "Hispanic Students" || category == "Native American Students" || category == "Two or More Races" || category == "White Students"
          if category == "Asian Students"
            category = category[0..4].downcase
          elsif
            category == "Black Students"
            category = category[0..4].downcase
          elsif
            category == "Native Hawaiian or Other Pacific Islander"
            category = "pacific_islander"
          elsif
            category == "Hispanic Students"
            category = category[0..7].downcase
          elsif
            category == "Native American Students"
            category = "native_american"
          elsif
            category == "Two or More Races"
            category = "two_or_more"
          elsif
            category == "White Students"
            category = category[0..4].downcase
          end
          hash = Hash[category.to_sym, (value.to_f * 1000).to_i / 1000.0]
          line = line.merge(hash)
        end
      end
    end
    return line
  end


  def dropout_rate_for_race_or_ethnicity(race)

  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year_input)

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

  end

  def participation_by_race_or_ethnicity_in_year(year_input)

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


end
