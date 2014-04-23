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
    @hash_table
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
        company_list << u["BusinessName"] unless u.has_value?(nil)
      end
    end
    
    company_list.each {|name| count[name] += 1}
    count.each {|key, value| print "#{key}: #{value} \n"}
  end

  def parse_wellformed_business
    parse_business
    @hash_table = []
    @businesses.each do |b|
      @hash_table << b.to_hash
    end
    @hash_table.each do |b|
      unless b.has_value?(nil)
        b.each {|key, value| print "#{key}: #{value.chomp} \n"}
        puts "\n"
      end
    end
    
  end

  def parse_wellformed_users
    parse_users
    @hash_table = []
    company_list = []
    users_by_company = Hash.new(0)

    @users.each do |u|
      @hash_table << u.to_hash
    end

    @hash_table.each do |u|
      if u["BusinessName"] != nil
        company_list << u["BusinessName"] unless company_list.include?(u["BusinessName"])
      end
    end

    company_list.each do |c|
      user_list = []
      @hash_table.each do |u|
        if u["BusinessName"] == c
          user_list << u.values unless u.has_value?(nil)
        end
        users_by_company[c] = user_list
      end
    end

    users_by_company.each  do |key, value| 
      puts "#{key}:"
      value.each do |v|
        puts v
        puts "\n"
      end
    end
  end

  def parse_malformed
    convert_csv_to_hash
    error_array = []
    count = 0
    @hash_table.each do |h|
      if h.has_value? nil
        count += 1
        puts "Record #{count}:"
        h.each_key do |k|
          puts "Missing #{k}" if h[k] == nil
        end
        puts "\n"
      end
    end
  end
end

reader = CsvReader.new
puts "Total records =  #{reader.get_total}"
puts "Total malformed records = #{reader.count_malformed}"
puts "Total well formed records = #{reader.count_total_wellformed}"
puts "Total well formed business records = #{reader.count_wellformed_business}"
puts "\n"
puts "Total wellformed user records by business:"
reader.count_wellformed_users
puts "\n"
puts "Welformed businesses-"
reader.parse_wellformed_business
puts "Welformed users by business-"
reader.parse_wellformed_users
reader.parse_malformed



