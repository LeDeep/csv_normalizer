require './lib/csv_reader'
require './lib/csv_parser'
require 'csv'

class CsvWriter

  def self.write_csv(file)
    parsed_csv = CsvParser.parse_csv(file)
    CSV.open(
      "normalized-" + file,
      "wb",
      write_headers: true,
      headers: %w[Timestamp Address ZIP FullName FooDuration BarDuration TotalDuration Notes]
      ) do |csv_out|
        parsed_csv.map do |row|
          csv_out << [row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7]]
      end
    end
  end
end
