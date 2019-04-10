require 'stack'
class LinearParking
  def initialize(parking_size = 10)
    @parking = Stack.new
    @temp_parking = Stack.new
    parking_size.times do
      @parking.push(nil)
    end
    @reserved_parking = Hash[(0..(parking_size - 1)).map {|v| [v, nil]}]
  end

  def reserve(house_no)
    empty_space = @reserved_parking.key(nil)
    if empty_space.nil?
      puts "Parking space not available for #{house_no}"
      return false
    end
    @reserved_parking[empty_space] = house_no
  end

  def unreserve(house_no)
    reserved_space = @reserved_parking.key(house_no)
    if reserved_slot.nil?
      puts "No reserved space for House #{house_no}"
      return false
    end
    @reserved_parking[reserved_space] = nil
  end

  def unreserve_all(house_no)
    @reserved_parking.select{|_,h_no| h_no == house_no}.size.times do
      unreserve(house_no)
    end
  end

  def park(house_no)
    reserved_parkings = get_reserved_parkings(house_no)
    if reserved_parkings.nil? || reserved_parkings.empty?
      puts "No parking reserved for house  #{house_no}"
      return false
    end
    park_on = nil
    reserved_parkings.each do |parking_no|
      while @parking.top >= 0 && @parking.top != parking_no
        @temp_parking.push(@parking.pop)
      end
      if @parking.last.nil?
        park_on = parking_no
        break
      end
    end
    if !park_on.nil? && @parking.top == park_on
      @parking.pop
      @parking.push(house_no)
    end
    @temp_parking.size.times do
      @parking.push(@temp_parking.pop)
    end
    puts "House no #{house_no}'s car Parked on its resrved parking no #{park_on}" unless park_on.nil?
    park_on.nil? ? false : park_on
  end

  def unpark(house_no)
    reserved_parkings = get_reserved_parkings(house_no)
    if reserved_parkings.nil? || reserved_parkings.empty?
      puts "No parking reserved for house  #{house_no}"
      return false
    end
    unpark_from = nil
    reserved_parkings.each do |parking_number|
      while @parking.top >= 0 && @parking.top != parking_number
        @temp_parking.push(@parking.pop)
      end

      unless @parking.last.nil?
        unpark_from = parking_number
        break
      end
    end

    if !unpark_from.nil? && @parking.top == unpark_from
      @parking.pop
      @parking.push(nil)
    end
    @temp_parking.size.times do
      @parking.push(@temp_parking.pop)
    end
    puts "House no #{house_no}'s car is un-parked from its resrved parking no #{unpark_from}" unless unpark_from.nil?
    unpark_from.nil? ? false : unpark_from
  end

  private

  def get_reserved_parkings(house_no)
    parking_reserved = @reserved_parking.select{|_,h_no| h_no == house_no}
    parking_reserved.keys.reverse
  end
end
