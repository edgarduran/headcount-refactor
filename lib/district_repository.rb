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
  parsed.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
  # data.each do |columns|
  #   district  = columns[:location]
  #   category  = columns[:category]
  #   year      = columns[:timeframe]
  #   stat_type = columns[:dataformat]
  #   value     = columns[:data]
  #   if district == "ACADEMY 20"
  #     if year == year_input.to_s && category == "Female Students" || year == year_input.to_s && category == "Male Students"
  #       if category == "Female Students"
  #         category = category[0..5].downcase
  #       elsif
  #         category == "Male Students"
  #         category = category [0..3].downcase
  #       end
  #       hash = Hash[category.to_sym, (value.to_f * 1000).to_i / 1000.0]
  #       line = line.merge(hash)
  #     end
  #   end
  # end
  # return line
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
