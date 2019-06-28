require_relative './models/service'
require_relative './models/serviceProvider'
require_relative './models/appointment'
require_relative './models/timeblock'
require_relative './lib/print'
require_relative './seeder/init'
require_relative './lib/colors'
require_relative './models/availability'
require_relative './controllers/serviceprovider_controller'
require_relative './controllers/service_controller'
require_relative './controllers/appointment_controller'
require_relative './controllers/availability_controller'
require 'tty-prompt'
$prompt = TTY::Prompt.new

commands = {
  'Add service' => Proc.new{service_add_prompt},
  'Remove service' => Proc.new{service_remove_prompt},
  'View services' => Proc.new{service_print($all_sp)},
  'Add service provider' => Proc.new{serviceprovider_add},
  'Remove service provider' => Proc.new{serviceprovider_remove},
  'View service providers' => Proc.new{print_serviceproviders($all_sp)},
  'Add appointments' => Proc.new{appointment_add_prompt},
  'Remove appointments' => Proc.new{appointment_remove_prompt},
  'Add availability' => Proc.new{availability_add_prompt},
  'Remove availability' => Proc.new{availability_remove_prompt},
  'View availability' => Proc.new{schedule_view('avail')},
  'View schedule' => Proc.new{schedule_view('appt')},
  'Exit program' => 0
}

# INITIALIZE
$all_sp = initData

user_is_done = false
while !user_is_done
  user_task = $prompt.select("What would you like to do?", commands.keys, cycle: true)
  if user_task != 'Exit program'
    commands[user_task].call()
  else
    user_is_done = true
  end
end