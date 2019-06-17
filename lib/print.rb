
def successPrint
  puts 'Success!'
  puts ''
end

def serviceErrorMessage
  puts ''
  puts 'Service Provider Not Found...'
  puts 'Choose from the following:'
  spPrint($all_sp)
end

def spPrint(all_sp)
  puts "#{BgMagenta}SERVICE PROVIDERS:#{Reset}"
  puts '------------------'
  all_sp.each do |sp|
    puts "#{Magenta}#{sp.name}#{Reset}"
  end
  puts '------------------'
  puts ''
end

def servicePrint(all_sp)
  puts "#{BgCyan}SERVICES:#{Reset}"
  puts '------------------'
  for sp in all_sp do
    sp.printServices()
  end
  puts '------------------'
  puts ''
end