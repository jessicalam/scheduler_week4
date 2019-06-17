
class Availability
  attr_reader :start_timeblock, :end_timeblock, :serviceProvider
  def initialize(start_timeblock, end_timeblock, serviceProvider) (
    @start_timeblock = start_timeblock
    @end_timeblock = end_timeblock
    @serviceProvider = serviceProvider
  )
  end

  def printDetails
    puts "Date: #{Green}#{@start_timeblock.month}/#{@start_timeblock.day}/#{@start_timeblock.year}#{Reset} | Start: #{Green}#{@start_timeblock.startTime.strftime("%T")}#{Reset} | Stop: #{Green}#{@start_timeblock.endTime.strftime("%T")}#{Reset} | Weekly #{Green}#{@start_timeblock.isWeekly}#{dayText}#{Reset}"
  end
  
end