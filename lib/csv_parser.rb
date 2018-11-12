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
      row[1] = format_address(row[1])
      row[2] = format_zip(row[2])
      row[3] = upcase_name(row[3])
      row[4] = duration_to_seconds(row[4])
      row[5] = duration_to_seconds(row[5])
      row[6] = total_duration(row[4], row[5])
      row[7] = format_note(row[7])
    end

    def unicode_validation(content)
      content.encode('utf-8', 'binary', invalid: :replace, undef: :replace) unless content.nil?
    end


    def format_timestamp(timestamp)
      time = Time.strptime(unicode_validation(timestamp), '%m/%d/%y %l:%M:%S').in_time_zone('US/Pacific')
      time.in_time_zone('US/Eastern').iso8601
    end

    def format_address(address)
      unicode_validation(address)
    end

    def format_zip(zip)
      unicode_validation(zip).rjust(5, '0')
    end

    def upcase_name(name)
      unicode_validation(name).upcase
    end

    def duration_to_seconds(duration)
      unicode_validation(duration).split(':').map { |a| a.to_f }.inject(0) { |a, b| a * 60 + b }
    end

    def total_duration(a, b)
      a + b
    end

    def format_note(note)
      unicode_validation(note)
    end
  end
end
