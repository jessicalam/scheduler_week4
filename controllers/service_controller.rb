require_relative './serviceprovider_controller'


def service_add_prompt
  service_name = $prompt.ask('Service Name:')
  while (service_name == nil)
    puts "Error: Invalid Name"
    service_name = $prompt.ask('Service Name:')
  end

  service_price = $prompt.ask('Service Price:')
  while (service_price == nil)
    puts "Error: Invalid Price"
    service_price = $prompt.ask('Service Price:')
  end

  service_length = $prompt.ask('Service Length (Mins):')
  while (service_length == nil)
    puts "Error: Invalid Length"
    service_length = $prompt.ask('Service Length (Mins):')
  end

  loop do
    service_provider = select_serviceprovider()
    if service_provider
      service_provider.service_add(Service.new(service_name, service_price, service_length))
      success_print()
      break
    else
      service_error_message()
    end
  end
end

def service_remove_prompt
  puts "Choose Service to Remove"
  service_print($all_sp)

  service_provider = select_serviceprovider()

  # services for this provider are placed in a hash for UI purposes only
  # this makes it so that the services print nicely when choosing the service to remove
  service_hash = convert_services_to_hash(service_provider)

  if service_provider.services.length == 0
    puts "No services found for service provider (#{Magenta}#{service_provider.name}#{Reset})."
  else
    loop do
      service_keys = service_hash.keys
      serv_to_be_deleted = $prompt.select("Choose Service to remove", service_keys, cycle: true)
      service_provider.services.delete(service_hash[serv_to_be_deleted])
      success_print()
      break
    end
  end
end

private

def convert_services_to_hash(service_provider)
  serv_hash = {}
  service_provider.services.each do |s|
    key = s.get_details
    serv_hash[key] = s
  end

  return serv_hash
end