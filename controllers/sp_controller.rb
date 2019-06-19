def spAdd
  provider_name = $prompt.ask('Provider Name:')
  while (provider_name == nil)
    puts "Error: Invalid Name"
    provider_name = $prompt.ask('Provider Name:')
  end

  provider_phone = $prompt.ask('Provider Phone Number:')
  while (provider_phone == nil)
    puts "Error: Invalid Phone"
    provider_phone = $prompt.ask('Provider Phone Number:')
  end

  $all_sp.push(ServiceProvider.new(provider_name, provider_phone, [], {}, []))
  successPrint()
end


def spRemove
  sp = select_sp()
  $prompt.yes?("Are you sure you want to delete #{sp.name}") ? $all_sp.delete(sp) : (puts 'Did Not Delete')
end

def select_sp
  sp_names = []
  $all_sp.each do |sp|
      sp_names << sp.name
  end
  get_sp_by_name($prompt.select("#{BgMagenta}Service Provider:#{Reset}", sp_names, cycle: true))
end

def get_sp_by_name(name)
  sp = $all_sp.select do |sp| 
    sp.name == name
  end
  if sp.length == 1
    return sp.first
  else
    return false
  end
end


def scheduleView(type)
  loop do
    puts "Choose a Service Provider to see their schedule:"
    sp = select_sp()
    if type == 'appt'
      sp.scheduleView()
      break
    elsif type == 'avail'
      sp.availabilityView()
      break
    end
  end
end