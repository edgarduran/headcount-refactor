class EconomicProfile < AllCsvFiles
  attr_accessor :graduation_rate_by_year

  def initialize(name)
    @name = name
  end

  def send_to_parser(csv_file)
    @parsed = Parse.new(@name, csv_file).parse_file
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
