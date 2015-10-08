require 'pry'
require 'csv'
require_relative 'all_csv_files'

class Parse

  def initialize(name, csv_file, data_hash={})
    @name = name
    @file = csv_file
    @data_hash = data_hash
  end

  def parse_file
    rows = read_csv
    hash = get_a_hash(rows)
  end

  def read_csv
    path = File.expand_path("../data", __dir__)
    fullpath = File.join(path, @file)
    CSV.read(fullpath, headers: true, header_converters: :symbol)
  end

  # def path
  #   path = File.expand_path("../data", __dir__)
  # end

  def get_a_hash(rows)
    big_hash = rows.map {|array| array.to_h}
    big_hash.select{|row| row.fetch(:location).upcase == @name.upcase}
  end


end
h = {:location=>"ACADEMY 20", :category=>"All Students", :timeframe=>"2011", :dataformat=>"Percent", :data=>"0.002"}
h[:category]
