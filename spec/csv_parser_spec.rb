require 'rspec'
require './lib/csv_parser'

RSpec.describe CsvParser do
  let(:csv_reader) { CsvReader.new}
  let(:csv_parser) { CsvParser }
  let(:csv_data) do [
    ['4/1/11 11:00:00 AM', '123 4th St, Anywhere, AA', '94121', 'Monkey Alberto', '1:23:32.123', '1:32:33.123', 'zzsasdfa', 'I am the very model of a modern major general'],
    ['3/12/14 12:00:00 AM', 'Somewhere Else, In Another Time, BB', '1', 'Superman übertan', '111:23:32.123', '1:32:33.123', 'zzsasdfa', 'This is some Unicode right here. ü ¡! 😀']
  ]
  end
  let(:csv_data_with_broken_utf8) do [
    ['4/1/11 11:00:00 AM', '123 4th St, Anywhere, AA', '94121', 'Monkey Alberto', '1:23:32.123', '1:32:33.123', 'zzsasdfa', 'I am the very model of a modern major general'],
    ['3/12/14 12:00:00 AM',"Somewhere Else, In Another Time, BB", '1', 'Superman übertan', '111:23:32.123', '1:32:33.123', 'zzsasdfa', 'This is some Unicode right h�xxx ü ¡! 😀']
  ]
  end
  let(:normalized_data) do [
    ["2011-04-01T14:00:00-04:00", "123 4th St, Anywhere, AA", "94121", "MONKEY ALBERTO", 5012.123, 5553.123, 10565.246, "I am the very model of a modern major general"],
    ["2014-03-12T15:00:00-04:00", "Somewhere Else, In Another Time, BB", "00001", "SUPERMAN ��BERTAN", 401012.123, 5553.123, 406565.246, "This is some Unicode right here. �� ��! ����"]
  ]
  end
  let(:normalized_utf8_data) do [
    ["2011-04-01T14:00:00-04:00", "123 4th St, Anywhere, AA", "94121", "MONKEY ALBERTO", 5012.123, 5553.123, 10565.246, "I am the very model of a modern major general"],
    ["2014-03-12T15:00:00-04:00", "Somewhere Else, In Another Time, BB", "00001", "SUPERMAN ��BERTAN", 401012.123, 5553.123, 406565.246, "This is some Unicode right h���xxx �� ��! ����"]
  ]
  end
  let(:file_name) { "test-sample.csv" }
  let(:file_name_broken_utf8) { "test-sample-broken-utf8.csv" }

  describe "#parse_csv" do
    it "parses the csv and normalizes the data" do
      expect(CSV).to receive(:read).with(file_name, headers: true, encoding: 'ISO-8859-1:UTF-8').and_return(csv_data)
      expect(csv_parser.parse_csv(file_name)).to eq normalized_data
    end

    it "parses csv with broken utf8 content and normalizes the data" do
      expect(CSV).to receive(:read).with(file_name_broken_utf8, headers: true, encoding: 'ISO-8859-1:UTF-8').and_return(csv_data_with_broken_utf8)
      expect(csv_parser.parse_csv(file_name_broken_utf8)).to eq normalized_utf8_data
    end
  end
end
