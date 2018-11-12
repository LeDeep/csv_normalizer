require 'csv'

class CsvReader
  class << self
    def read_csv(file)
      CSV.read(file, headers: true, encoding: 'ISO-8859-1:UTF-8')
    end
  end
end
