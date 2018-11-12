require 'rspec'
require './lib/csv_reader'

RSpec.describe CsvReader do
  let(:csv_reader) { CsvReader }
  let(:csv_data) do [
    ["Timestamp", "Address", "ZIP", "FullName", "FooDuration", "BarDuration", "TotalDuration", "Notes"],
    ['4/1/11 11:00:00 AM', '123 4th St, Anywhere, AA', '94121', 'Monkey Alberto', '1:23:32.123', '1:32:33.123', 'zzsasdfa', 'I am the very model of a modern major general'],
    ['3/12/14 12:00:00 AM', 'Somewhere Else, In Another Time, BB', '1', 'Superman übertan', '111:23:32.123', '1:32:33.123', 'zzsasdfa', 'This is some Unicode right here. ü ¡! 😀']
  ]
  end
  let(:file_name) { "test-sample.csv" }

  describe "#read_csv" do
    before do
      expect(CSV).to receive(:read).with(file_name, headers: true).and_return(csv_data)
    end

    it "returns all rows of csv data" do
      expect(csv_reader.read_csv(file_name).length).to eq 3
    end
  end
end
