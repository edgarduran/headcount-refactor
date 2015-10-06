require 'csv'
require 'pry'

class DistrictRepository
  def self.from_csv(path)
    filename = File.expand_path "High school graduation rates.csv", path
    rows = CSV.readlines(filename, headers: true, header_converters: :symbol).map(&:to_h)

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
    Enrollment.new(@data)
  end
end

class Enrollment
  attr_accessor :graduation_rate_by_year

  def initialize(data)
    @data = data
  end

  def graduation_rate_by_year
    @data.map { |row| [row.fetch(:timeframe).to_i, (row.fetch(:data).to_f * 1000).to_i/ 1000.0] }.to_h
  end

  def graduation_rate_in_year(year)
    time = graduation_rate_by_year
    time.fetch(year)
  end
end
