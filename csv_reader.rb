require 'csv'

class CsvReader

  attr_accessor :users, :businesses

  # def read_in_csv(filename)
  #   CSV.foreach(filename, headers: true) do |row|
  #     puts row["Name"]
  #   end
  # end

  def parse_business
    @businesses = []
    CSV.foreach("businesses.csv", headers: true) do |row|
      @businesses << row
    end
    @businesses
  end

  def parse_users
    @users = []
    CSV.foreach("users.csv", headers: true) do |row|
      @users << row
    end
    @users
  end

  def convert_csv_to_hash
    parse_business
    parse_users
    @hash_table = []
    @businesses.each do |b|
      @hash_table << b.to_hash
    end

    @users.each do |b|
      @hash_table << b.to_hash
    end
  end

  def count_malformed
    convert_csv_to_hash
    count = 0
    @hash_table.each do |b|
      if b.has_value?(nil)
        count += 1
      end
    end
    count
  end

  def get_total
    parse_users.count + parse_business.count
  end

  def count_wellformed
    convert_csv_to_hash
    count = 0
    @hash_table.each do |b|
      unless b.has_value?(nil)
        count += 1
      end
    end
    count
  end

end

reader = CsvReader.new
puts "Total records =  #{reader.get_total}"
puts "Total malformed records = #{reader.count_malformed}"
puts "Total well formed records = #{reader.count_wellformed}"


