require 'csv'
require_relative 'all_csv_files'
require_relative 'parser'
require_relative 'district'

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
    @districts = {}
    @district_data.each do |name, data|
      @districts[name] = District.new(name, @district_data.fetch(name.upcase))

    end
  end

  def find_by_name(name)
    if @district_data.keys.include?(name.upcase) == false
      return nil
    end
    name = name.upcase
    @districts[name]
  end

  def find_all_matching(name_fragment)
    matching = []
    district_names = @districts.keys
    district_names.each do |name|
      matching << @districts[name] if name.include?(name_fragment.upcase)
    end
    matching
  end
end
