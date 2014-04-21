class Business

  attr_accessible :name, :address, :city, :state, :zip, :phone, :fax, :email

  def initialize(name, address, city, state, zip, phone, fax, email)
    @name, @address, @city, @state, @zip, @phone, @fax = name, address, city, state, zip, phone, fax, email
  end

end