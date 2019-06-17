def availabilityAdd
    spPrint($all_sp)
    puts 'Provider Name:'
    sp = select_sp()
    month = $prompt.ask('Date (MM):')
    day = $prompt.ask('Date (DD):')
    year = $prompt.ask('Date (YYYY):')
    start_time = $prompt.ask('Start Time (ex: 13:30):')
    end_time = $prompt.ask('End Time (ex: 14:30):')

    
    puts 'Will This Availability Reoccur Weekly?'
    isWeekly = y_or_n()
  
    start_temp = start_time.split(':')
    start_hour = start_temp[0].to_i
    start_minute = start_temp[1].to_i
  
    end_temp = end_time.split(':')
    end_hour = end_temp[0].to_i
    end_minute = end_temp[1].to_i
  
    length = (end_hour * 60 +end_minute) - (start_hour * 60 + start_minute)
  
    start_datetime = DateTime.new(year.to_i, month.to_i, day.to_i, start_hour, start_minute)
    timeblock = TimeBlock.new(start_datetime, isWeekly, length)
  
    #sp.add_appointment(service, TimeBlock.new(month, day, year, start_datetime, isWeekly, service.length), client_name)
    sp.add_availability(timeblock)
    successPrint()
  end
  
  def availabilityRemove
    puts 'Provider Name To Remove Availability:'
    sp = select_sp()
    availability_hash = {}
    sp.availability.each do |av|
      key = av.getDetails
      availability_hash[key] = av
    end
    if sp.availability.length == 0
      puts "No availability found for service provider (#{Magenta}#{provider_name}#{Reset})."
    else
      loop do
        availability_keys = availability_hash.keys
        av_to_be_deleted = $prompt.select("Choose Availability to remove", availability_keys, cycle: true)
        sp.availability.delete(availability_hash[av_to_be_deleted])
        successPrint()
        break
      end
    end
  end

  private

  def y_or_n
    loop do
      yn = $prompt.ask('(y/n):')
      if yn == 'y'
        return true
      elsif yn == 'n'
        return false
      else
        puts "Enter y or n"
      end
    end
  end