require 'pry'
require 'csv'
require_relative 'all_csv_files'

class Parse

  def initialize(name, csv_file, data_hash={})
    @name = district_name
    @file = csv_file
    @data_hash = data_hash
  end

  def parse_runner
    rows = create_row_table
    hash = return_hash_from_row_table(rows)
  end

  def create_row_table
    path = File.expand_path("../data", __dir__)
    fullpath = File.join(path, @file)
    CSV.read(fullpath, headers: true, header_converters: :symbol)
  end

  # def path
  #   path = File.expand_path("../data", __dir__)
  # end

  def return_hash_from_row_table(rows)
    final_rows = rows.map {|array| array.to_h}
    final_rows.select{|row| row.fetch(:location).upcase == @name.upcase}
  end


end
