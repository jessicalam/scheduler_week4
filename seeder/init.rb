# FUNCTION TO INITIALIZE A FAKE DATA SET

def initData
  all_sp = []
  serviceSet1 = [
    Service.new('Helping', 200, 60),
    Service.new('Smiling', 100, 120),
    Service.new('Cursing', 50, 60)
  ]
  serviceSet2 = [
    Service.new('Whining', 300, 180),
    Service.new('Complimenting', 150, 120)
  ]

  all_sp.push(ServiceProvider.new('Jim', '1111111111', serviceSet1, [], []))
  all_sp.push(ServiceProvider.new('Sue', '2222222222', serviceSet2, [], []))

  datetime1 = DateTime.new(2019, 12, 12, 12)
  datetime2 = DateTime.new(2019, 11, 11, 11)
  appointment1 = Appointment.new(TimeBlock.new(datetime1, false, 120), serviceSet1[0], 'Larry', all_sp[0])
  appointment2 = Appointment.new(TimeBlock.new(datetime2, true, 120), serviceSet1[1], 'Emma', all_sp[0])
  appointment3 = Appointment.new(TimeBlock.new(datetime2, false, 120), serviceSet2[1], 'Bobby', all_sp[0])

  all_sp[0].appointments.push(appointment1)
  all_sp[0].appointments.push(appointment2)
  all_sp[1].appointments.push(appointment3)
  return all_sp
end
