require_relative '../config/environment'
require_relative './interface/login.rb'
require_relative './interface/launch_broker_interface.rb'
require_relative './interface/launch_investor_interface.rb'


# puts "HELLO WORLD"
#reference leftmargin = "          "
#reference topmargin = "\n\n\n\n\n\n"

def menu_select(user)
    user.class == Investor ? launch_investor_interface : launch_broker_interface
end

def run
    user = login

    menu_select(user)
    # while true
    # => login screen
            #username, password
    #  > corresponding menu
    #
    # end

end

run
