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
