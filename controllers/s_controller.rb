require_relative './sp_controller'


def serviceAddPrompt
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
    sp = select_sp()
    if sp
      sp.serviceAdd(Service.new(service_name, service_price, service_length))
      successPrint()
      break
    else
      serviceErrorMessage()
    end
  end
end

def serviceRemovePrompt
  puts "Choose Service to Remove"
  servicePrint($all_sp)

  sp = select_sp()

  # services for this provider are placed in a hash for UI purposes only
  # this makes it so that the services print nicely when choosing the service to remove
  service_hash = convert_services_to_hash(sp)

  if sp.services.length == 0
    puts "No services found for service provider (#{Magenta}#{sp.name}#{Reset})."
  else
    loop do
      service_keys = service_hash.keys
      serv_to_be_deleted = $prompt.select("Choose Service to remove", service_keys, cycle: true)
      sp.services.delete(service_hash[serv_to_be_deleted])
      successPrint()
      break
    end
  end
end

private

def convert_services_to_hash(sp)
  serv_hash = {}
  sp.services.each do |s|
    key = s.getDetails
    serv_hash[key] = s
  end

  return serv_hash
end