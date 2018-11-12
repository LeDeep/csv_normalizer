require 'csv'

class CsvReader

  def self.read_csv(file)
    CSV.read(file, headers: true)
  end
end
