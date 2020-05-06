require_relative '../config/environment'
require_relative './login.rb'

# puts "HELLO WORLD"

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
