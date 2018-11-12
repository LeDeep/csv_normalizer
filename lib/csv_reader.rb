require 'csv'

class CsvReader

  def self.read_csv(file)
    p file
    CSV.read(file, headers: true)
  end
end
