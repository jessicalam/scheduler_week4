require_relative './serviceprovider_controller'
require_relative './service_controller'

def appointment_add_prompt
  client_name = $prompt.ask('Client Name:')
  while (client_name == nil)
    puts "Error: Name"
    client_name = $prompt.ask('Client Name:')
  end

  puts "Hello #{client_name}! Choose Provider & Service to Schedule"
  service_print($all_sp)

  puts 'Provider Name:'
  service_provider = select_serviceprovider()

  serv_names = []
  service_provider.services.each do |serv|
    serv_names << serv.name
  end
  service_name = $prompt.select("#{BgMagenta}Service Name:#{Reset}", serv_names, cycle: true)

  # check here for usability
  is_available = false
  while !is_available
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
    temp = start_time.split(':')
    hour = temp[0].to_i
    minute = temp[1].to_i

    puts 'Will This Appointment Reoccur Weekly?'
    isWeekly = y_or_n()
    service = service_provider.contains_service(service_name)

    start_datetime = DateTime.new(year.to_i, month.to_i, day.to_i, hour, minute)
    if service_provider.add_appointment(service, TimeBlock.new(start_datetime, isWeekly, service.length), client_name)
      is_available = true
    end
  end
end

def appointment_remove_prompt
  print_serviceproviders($all_sp)
  puts 'Provider Name To Cancel Appointment:'
  service_provider = select_serviceprovider()

  client_name = $prompt.ask('Your Name:')

  # appointments for this provider are placed in a hash for UI purposes only
  # this makes it so that the appointments print nicely when choosing the appointment to remove
  appointment_hash, num_appointments_with_client = count_appointments_and_convert_to_hash(service_provider, client_name)

  if num_appointments_with_client == 0
    puts "No appointments found for client (#{Cyan}#{client_name}#{Reset}) under service provider (#{Magenta}#{service_provider.name}#{Reset})."
  else
    loop do
      appointment_keys = appointment_hash.keys
      a_to_be_deleted = $prompt.select("Choose Appointment to remove", appointment_keys, cycle: true)
      service_provider.appointments.delete(appointment_hash[a_to_be_deleted])
      success_print()
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

def count_appointments_and_convert_to_hash(service_provider, client_name)
  app_hash = {}
  num_apps = 0
  service_provider.appointments.each do |a|
    if a.client_name == client_name
      key = a.get_details
      app_hash[key] = a
      num_apps += 1
    end
  end
  return app_hash, num_apps
end