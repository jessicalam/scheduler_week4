class TimeBlock
  attr_reader :month, :day, :year, :startTime, :endTime, :dayOfWeek, :isWeekly
  def initialize(startTime, isWeekly, length) (
    @month = startTime.strftime("%m")
    @day = startTime.strftime("%d")
    @year = startTime.strftime("%Y")
    @startTime = startTime
    @isWeekly = isWeekly
    @endTime = startTime + ((length.to_f)/24)/60
    @dayOfWeek = startTime.strftime("%A")
  )
  end

  def contains(timeblock2)
    #return true if the timeblock contains timeblock2
    starts_after = (timeblock2.startTime >= @startTime)
    ends_before = (timeblock2.endTime <= @endTime)
    return starts_after && ends_before
  end

  def contains_time(timeblock2)
    #return true if the timeblock contains timeblock2 (regardless of date)

    startTime1 = Time.parse(@startTime.strftime("%H:%M:%S %z"))
  	startTime2 = Time.parse(timeblock2.startTime.strftime("%H:%M:%S %z"))
  	endTime1 = Time.parse(@endTime.strftime("%H:%M:%S %z"))
    endTime2 = Time.parse(timeblock2.endTime.strftime("%H:%M:%S %z"))

    starts_after = (startTime2 >= startTime1)
    ends_before = (endTime2 <= endTime1)
    return starts_after && ends_before
  end

  def overlaps(timeblock2)
    #returns true if timeblocks overlap

    check1 = (timeblock2.startTime >= @startTime &&
        timeblock2.startTime <= @endTime)
    check2 = (@startTime >= timeblock2.startTime &&
        @startTime <= timeblock2.endTime)
    return check1 || check2
  end

  def overlaps_time(timeblock2)
    #returns true if timeblocks overlap (regardless of date)

  	startTime1 = Time.parse(@startTime.strftime("%H:%M:%S %z"))
  	startTime2 = Time.parse(timeblock2.startTime.strftime("%H:%M:%S %z"))
  	endTime1 = Time.parse(@endTime.strftime("%H:%M:%S %z"))
  	endTime2 = Time.parse(timeblock2.endTime.strftime("%H:%M:%S %z"))

    check1 = (startTime2 >= startTime1 &&
        startTime2 <= endTime1)

    check2 = (startTime1 >= startTime2 &&
        startTime1 <= endTime2)

    return check1 || check2
  end

  def calculate_endtime(startTime, length)
    return startTime + ((length.to_f)/24)/60
  end

  def printDetails
    puts self.getDetails
  end

  def getDetails
    "Date: #{Green}#{@startTime.month}/#{@startTime.day}/#{@startTime.year}#{Reset} | Start: #{Green}#{@startTime.strftime("%T")}#{Reset} | Stop: #{Green}#{@endTime.strftime("%T")}#{Reset} | Weekly #{Green}#{@isWeekly}#{Reset}"
  end
end