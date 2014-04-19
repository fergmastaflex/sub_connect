require 'csv'

class CsvReader

  def initialize

  end

  def read_in_csv(filename)
    CSV.foreach(filename, headers: true) do |row|
      puts row
    end
  end

end