require_relative '../config/environment'
require_relative './interface/login.rb'
require_relative './interface/launch_broker_interface.rb'
require_relative './interface/launch_investor_interface.rb'


# puts "HELLO WORLD"
#reference leftmargin = "          "
#reference topmargin = "\n\n\n\n\n\n"

def menu_select(user)
    user.class == Investor ? launch_investor_interface(user) : launch_broker_interface(user)
end

def run
    user = login
    puts "          It's good to see you again, #{user.first_name}"
    puts "\n\n"
    gets
    menu_select(user)
end

run
