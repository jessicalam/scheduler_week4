def availabilityAddPrompt
  spPrint($all_sp)
  puts 'Provider Name:'
  service_provider = select_sp()

  month = $prompt.ask('Date (MM):')
  while (month.to_i < 1 || month.to_i > 12 || !month)
    puts "Error: Invalid Month"
    month = prompt.ask('Date (MM):')
  end

  day = $prompt.ask('Date (DD):')
  while (day.to_i < 1 || day.to_i > 31 || !day)
    puts "Error: Invalid Day"
    day = prompt.ask('Date (DD):')
  end

  year = $prompt.ask('Date (YYYY):')
  while (year.to_i < 2018 || !year)
    puts "Error: Invalid Year"
    day = prompt.ask('Date (YYYY):')
  end

  start_time = $prompt.ask('Start Time (ex: 13:30):')
  while (start_time == nil)
    puts "Error: Start Time"
    day = prompt.ask('Start Time (ex: 13:30):')
  end

  end_time = $prompt.ask('End Time (ex: 14:30):')
  while (end_time == nil)
    puts "Error: End Time"
    end_time = $prompt.ask('End Time (ex: 14:30):')
  end


  puts 'Will This Availability Reoccur Weekly?'
  isWeekly = y_or_n()

  start_temp = start_time.split(':')
  start_hour = start_temp[0].to_i
  start_minute = start_temp[1].to_i

  end_temp = end_time.split(':')
  end_hour = end_temp[0].to_i
  end_minute = end_temp[1].to_i

  length = (end_hour * 60 + end_minute) - (start_hour * 60 + start_minute)

  start_datetime = DateTime.new(year.to_i, month.to_i, day.to_i, start_hour, start_minute)
  timeblock = TimeBlock.new(start_datetime, isWeekly, length)

  service_provider.add_availability(timeblock)
  successPrint()
end

def availabilityRemovePrompt
  puts 'Provider Name To Remove Availability:'
  service_provider = select_sp()

  # availability for this provider is placed in a hash for UI purposes only
  # this makes it so that the availability prints nicely when choosing the availability to remove
  availability_hash = convert_availability_to_hash(service_provider)

  if service_provider.availability.length == 0
    puts "No availability found for service provider (#{Magenta}#{service_provider.name}#{Reset})."
  else
    loop do
      availability_keys = availability_hash.keys
      av_to_be_deleted = $prompt.select("Choose Availability to remove", availability_keys, cycle: true)
      service_provider.availability.delete(availability_hash[av_to_be_deleted])
      successPrint()
      break
    end
  end
end

private

def y_or_n
  loop do
    yn = $prompt.ask('(y/n):')
    if yn == 'y' || yn == 'yes'
      return true
    elsif yn == 'n' || yn == 'no'
      return false
    else
      puts "Enter y or n"
    end
  end
end

def convert_availability_to_hash(service_provider)
  av_hash = {}
  service_provider.availability.each do |av|
    key = av.getDetails
    av_hash[key] = av
  end

  return av_hash
end