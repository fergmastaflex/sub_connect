require './csv_reader'

describe CsvReader, "#parse_business" do
  it "returns full business array" do
    reader = CsvReader.new
    reader.parse_business
    reader.businesses.should_not be_empty 
  end
end

describe CsvReader, "#parse_user" do
  it "returns full user array" do
    reader = CsvReader.new
    reader.parse_users
    reader.users.should_not be_empty
  end
end

describe CsvReader, "#convert_csv_to_hash" do
  it "returns full hash_array" do
    reader = CsvReader.new
    reader.convert_csv_to_hash.should_not be_empty
  end

  it "Should contain all records" do
    reader = CsvReader.new
    reader.convert_csv_to_hash.count.should eq(reader.businesses.count + reader.users.count)
  end

  it "Should only contain hashes" do
    reader = CsvReader.new
    reader.convert_csv_to_hash.each do |h|
      h.class.should eq Hash
    end
  end
end

describe CsvReader, "#count_malformed" do
  
  it "Should return a number" do
    reader = CsvReader.new
    reader.count_malformed.class.should eq Fixnum
  end

  it "Should count up if nil found" do
    reader = CsvReader.new
    reader.count_malformed.should_not eq 0
  end
end

describe CsvReader, "#get_total" do
  it "Should return a number" do
    reader = CsvReader.new
    reader.get_total.class.should eq Fixnum
  end
end

describe CsvReader, "#count_total_wellformed" do
  
  it "Should return a number" do
    reader = CsvReader.new
    reader.count_total_wellformed.class.should eq Fixnum
  end

  it "Should count up if nil found" do
    reader = CsvReader.new
    reader.count_total_wellformed.should_not eq 0
  end
end

describe CsvReader, "#count_wellformed_business" do
  
  it "Should return a number" do
    reader = CsvReader.new
    reader.count_wellformed_business.class.should eq Fixnum
  end

  it "Should count up if nil found" do
    reader = CsvReader.new
    reader.count_wellformed_business.should_not eq 0
  end
end

describe CsvReader, "#count_wellformed_users" do
  
  it "Should return a Hash" do
    reader = CsvReader.new
    reader.count_wellformed_users.class.should eq Hash
  end

  it "Should count up if nil found" do
    reader = CsvReader.new
    reader.count_wellformed_users.each_value {|v| v.should_not eq 0}
  end
end

describe CsvReader, "#parse_wellformed_business" do
  it "Detect nil items in Hash" do
    reader = CsvReader.new
    reader.parse_wellformed_business.should_not include(nil)
  end

  it "Should return array" do
    reader = CsvReader.new
    reader.parse_wellformed_business.class.should eq Array
  end

  it "Array should contain Hashes" do
    reader = CsvReader.new
    reader.parse_wellformed_business.each do |b|
      b.class.should eq Hash
    end
  end
end

describe CsvReader, "#parse_wellformed_users" do
  it "Detect nil items in Hash" do
    reader = CsvReader.new
    reader.parse_wellformed_users.should_not include(nil)
  end

  it "Should return Hash" do
    reader = CsvReader.new
    reader.parse_wellformed_users.class.should eq Hash
  end

  it "Hash should not be empty" do
    reader = CsvReader.new
    reader.parse_wellformed_users.each_value {|v| v.should_not eq nil}
  end
end

describe CsvReader, "#parse_malformed" do
  it "Detect nil items in Hash" do
    reader = CsvReader.new
    reader.parse_wellformed_users.should_not include(nil)
  end
end





