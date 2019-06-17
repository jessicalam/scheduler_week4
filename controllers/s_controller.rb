require_relative './sp_controller'


def serviceAdd
    service_name = $prompt.ask('Service Name:')
    service_price = $prompt.ask('Service Price:')
    service_length = $prompt.ask('Service Length (Mins):')
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

  def serviceRemove
    puts "Choose Service to Remove"
    servicePrint($all_sp)
    sp = select_sp()
    service_hash = {}
    sp.services.each do |s|
      key = s.getDetails
      service_hash[key] = s
    end
    if sp.services.length == 0
      puts "No services found for service provider (#{Magenta}#{provider_name}#{Reset})."
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