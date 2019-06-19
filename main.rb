require_relative './models/service'
require_relative './models/serviceProvider'
require_relative './models/appointment'
require_relative './models/timeblock'
require_relative './lib/print'
require_relative './seeder/init'
require_relative './lib/colors'
require_relative './models/availability'
require_relative './controllers/sp_controller'
require_relative './controllers/s_controller'
require_relative './controllers/a_controller'
require_relative './controllers/avail_controller'
require 'tty-prompt'
$prompt = TTY::Prompt.new

commands = {
  'Add service' => Proc.new{serviceAddPrompt},
  'Remove service' => Proc.new{serviceRemovePrompt},
  'View services' => Proc.new{servicePrint($all_sp)},
  'Add service provider' => Proc.new{spAdd},
  'Remove service provider' => Proc.new{spRemove},
  'View service providers' => Proc.new{spPrint($all_sp)},
  'Add appointments' => Proc.new{appointmentAddPrompt},
  'Remove appointments' => Proc.new{appointmentRemovePrompt},
  'Add availability' => Proc.new{availabilityAddPrompt},
  'Remove availability' => Proc.new{availabilityRemovePrompt},
  'View availability' => Proc.new{scheduleView('avail')},
  'View schedule' => Proc.new{scheduleView('appt')},
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