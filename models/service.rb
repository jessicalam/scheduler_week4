
class Service
  attr_reader :name, :price, :length, :print_details
  def initialize(name, price, length) (
    @name = name
    @price = price
    @length = length
  )
  end

  def print_details
    puts get_details
  end

  def get_details
    "#{Cyan}#{@name}#{Reset}, #{Green}$#{@price}#{Reset}, #{Yellow}#{@length} Minutes#{Reset}"
  end
end