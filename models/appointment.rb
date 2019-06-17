class Appointment
  attr_reader :timeblock, :service, :client_name, :serviceProvider
  def initialize(timeblock, service, client_name, serviceProvider) (
    @timeblock = timeblock
    @service = service
    @client_name = client_name
    @serviceProvider = serviceProvider
  )
  end

  def printDetails()
    puts getDetails
  end

  def getDetails()
    dayText = nil
    if @timeblock.isWeekly
      dayText = " - on #{@timeblock.dayOfWeek}'s"
    end
    return "#{BgCyan}APPOINTMENT: #{Reset} Provider: #{Magenta}#{@serviceProvider.name}#{Reset}, Client: #{Cyan}#{@client_name}#{Reset}, Service: #{Yellow}#{@service.name}#{Reset} \n Date: #{Green}#{@timeblock.month}/#{@timeblock.day}/#{@timeblock.year}#{Reset} | Start: #{Green}#{@timeblock.startTime.strftime("%T")}#{Reset} | Stop: #{Green}#{@timeblock.endTime.strftime("%T")}#{Reset} | Weekly #{Green}#{@timeblock.isWeekly}#{dayText}#{Reset} \n ----------------------------------------------------------------------"
  end
end