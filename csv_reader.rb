require 'csv'

class CsvReader

  attr_accessor :users, :businesses

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

  def count_total_wellformed
    convert_csv_to_hash
    count = 0
    @hash_table.each do |b|
      unless b.has_value?(nil)
        count += 1
      end
    end
    count
  end

  def count_wellformed_business
    parse_business
    @hash_table = []
    count = 0
    @businesses.each do |b|
      @hash_table << b.to_hash
    end

    @hash_table.each do |b|
      unless b.has_value?(nil)
        count += 1
      end
    end
    count
  end

  def count_wellformed_users
    parse_users
    @hash_table = []
    company_list = []
    count = Hash.new(0)

    @users.each do |u|
      @hash_table << u.to_hash
    end

    @hash_table.each do |u|
      if u["BusinessName"] != nil
        company_list << u["BusinessName"]
      end
    end
    
    company_list.each {|name| count[name] += 1}
    count.each {|key, value| print "#{key}: #{value} \n"}
    return nil
  end

  def parse_wellformed_business
    parse_business
    @hash_table = []
    @businesses.each do |b|
      @hash_table << b.to_hash
    end
    @hash_table.each do |b|
      unless b.has_value?(nil)
        b.each {|key, value| print "#{key}: #{value} "}
        puts "\n"
      end
    end
    return nil
  end

end

reader = CsvReader.new
puts "Total records =  #{reader.get_total}"
puts "Total malformed records = #{reader.count_malformed}"
puts "Total well formed records = #{reader.count_total_wellformed}"
puts "Total well formed business records = #{reader.count_wellformed_business}"
puts "Total wellformed user records by business:"
puts reader.count_wellformed_users
puts "Welformed businesses:"
puts reader.parse_wellformed_business



