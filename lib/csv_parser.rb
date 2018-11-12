require 'csv'
require 'active_support/time'
require './lib/csv_reader'

class CsvParser
  class << self

    def parse_csv(file)
      csv = CsvReader.read_csv(file)
      csv.map do |row|
        normalize_csv(row)
      end
      csv
    end

    private

    def normalize_csv(row)
      row[0] = format_timestamp(row[0])
      row[1] = row[1]
      row[2] = format_zip(row[2])
      row[3] = upcase_name(row[3])
      row[4] = duration_to_seconds(row[4])
      row[5] = duration_to_seconds(row[5])
      row[6] = total_duration(row[4], row[5])
      row[7] = row[7]
    end

    def format_timestamp(timestamp)
      time = Time.strptime(timestamp, '%m/%d/%y %l:%M:%S').in_time_zone('US/Pacific')
      time.in_time_zone('US/Eastern').iso8601
    end

    def format_zip(zip)
      zip.rjust(5, '0')
    end

    def upcase_name(name)
      name.upcase
    end

    def duration_to_seconds(duration)
      duration_array = duration.split(":")
      duration_array[0].to_f * 3600 + duration_array[1].to_f * 60 + duration_array[2].to_f
    end

    def total_duration(a, b)
      a + b
    end
  end
end
