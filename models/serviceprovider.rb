class ServiceProvider
  attr_reader :name, :phoneNum, :services, :availability, :appointments, :service_add
  def initialize(name, phoneNum, services, availability, appointments) (
    @name = name
    @phoneNum = phoneNum
    @services = services
    @availability = availability
    @appointments = appointments
  )
  end

  def service_remove(service_name) (
    for service in @services do
      if service.name == service_name
        @services.delete(service)
      end
    end
    )
  end

  def print_services()
    puts "#{Magenta}#{@name}#{Reset}'s Services:"
    if @services.empty?
      puts "No services found for service provider (#{Magenta}#{@name}#{Reset})"
    else
      @services.each do |s|
        s.print_details
      end
    end
  end

  def schedule_view()
    if @appointments.empty?
      puts "No appointments found for service provider (#{Magenta}#{@name}#{Reset})"
    else
      puts
      puts "#{Magenta}#{@name}#{Reset}'s Appointments:"
      @appointments.each do |a|
        a.print_details
      end
    end
    puts
  end

  def availability_view()
    if @availability.empty?
      puts "No availability found for service provider (#{Magenta}#{@name}#{Reset})"
    else
      puts
      puts "#{Magenta}#{@name}#{Reset}'s Availability:"
      @availability.each do |a|
        puts "#{BgCyan}AVAILABILITY#{Reset}"
        a.print_details
      end
    end
    puts
  end

  def contains_service(name) (
    for service in @services do
      if service.name == name
        return service
      end
    end
    return false
  )
  end

  def service_add(service) (
    @services.push(service)
  )
  end

  def is_available(service, timeblock, isWeekly)
    #add check to make sure timeblock is in the future
    is_future_date = (timeblock.startTime >= DateTime.now)

    #check if provider offers service
    service_offered = contains_service(service.name)

    #check for overlap with provider's appointments
    overlap_with_appointments = conflict_with_appointments?(service, timeblock, isWeekly)

    #check if potential appointment is within provider's availability
    availability_compatible = availability_contains?(service, timeblock, isWeekly)

    return is_future_date && service_offered && 
      !overlap_with_appointments && availability_compatible

  end

  def conflict_with_appointments?(service, timeblock, isWeekly)
    puts('-----------------')
    @appointments.each do |appointment|
      #check for overlap if either appointment is weekly
      if appointment.timeblock.isWeekly || isWeekly
        if appointment.timeblock.dayOfWeek == timeblock.dayOfWeek
          if appointment.timeblock.overlaps_time(timeblock)
            return true
          end
        end
      end

      #check for overlap if dates are the same
      if appointment.timeblock.overlaps(timeblock)
        return true
      end
    end
    return false
  end

  def availability_contains?(service, timeblock, isWeekly)
    @availability.each do |av|
      #check if appointment is contained within availability if availability is weekly
      if av.isWeekly || isWeekly
        if av.dayOfWeek == timeblock.dayOfWeek
          if !av.contains_time(timeblock)
            return false
          end
        end
      else
        #check if appointment is contained within availability on same date
        if av.month == timeblock.month && av.day == timeblock.day && av.year == timeblock.year
          if !av.contains(timeblock)
            return false
          end
        end
      end
    end
    return true
  end

  def add_appointment(service, timeblock, client)
    #add appointment to provider's schedule
    if is_available(service, timeblock, timeblock.isWeekly)
      appointment = Appointment.new(timeblock, service, client, self)
      @appointments << appointment
      success_print()
      return true
    else
      puts "#{Red}The service provider you requested is not available at this time."
      puts "Please choose a different date/time.#{Reset}"
      return false
    end
  end

  def add_availability(timeblock)
    #need to add a check here? probably not
    @availability << timeblock
  end

end