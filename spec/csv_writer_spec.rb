require 'rspec'
require './lib/csv_writer'
require './lib/csv_parser'
require 'byebug'

RSpec.describe CsvWriter do
  let(:csv_parser) { class_double("CsvParser") }
  let(:csv_writer) { CsvWriter }
  let(:csv_data) do [
    ['4/1/11 11:00:00 AM', '123 4th St, Anywhere, AA', '94121', 'Monkey Alberto', '1:23:32.123', '1:32:33.123', 'zzsasdfa', 'I am the very model of a modern major general'],
    ['3/12/14 12:00:00 AM', 'Somewhere Else, In Another Time, BB', '1', 'Superman übertan', '111:23:32.123', '1:32:33.123', 'zzsasdfa', 'This is some Unicode right here. ü ¡! 😀']
  ]
  end
  let(:normalized_data) do [
    ["2011-04-01T14:00:00-04:00", "123 4th St, Anywhere, AA", "94121", "MONKEY ALBERTO", 5012.123, 5553.123, 10565.246, "I am the very model of a modern major general"],
    ["2014-03-12T15:00:00-04:00", "Somewhere Else, In Another Time, BB", "00001", "SUPERMAN ÜBERTAN", 401012.123, 5553.123, 406565.24600000004, "This is some Unicode right here. ü ¡! 😀"]
  ]
  end
  let(:file_name) { "test-sample.csv" }
  let(:normalized_file_name) { "normalized-test-sample.csv" }

  before do
    allow(CSV).to receive(:read).with(file_name, headers: true).and_return(csv_data)
    expect(CSV).to receive(:open).with(normalized_file_name, "wb",  {:headers=>["Timestamp", "Address", "ZIP", "FullName", "FooDuration", "BarDuration", "TotalDuration", "Notes"], write_headers: true}).and_return(csv_data)
  end

  it "writes to file" do
    expect(csv_writer.write_csv(file_name)).to eq normalized_data
  end
end
