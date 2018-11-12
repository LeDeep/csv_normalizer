require 'csv'

class CsvReader
  class << self
    def read_csv(file)
      CSV.read(file, headers: true)
    end
  end
end
