

def investor_help
    puts "anything"
    gets

end

def logout
    puts "goodbye!"
    gets

end

def quote(invstr, tckr)
    invstr.stock_position(tckr)
    gets
end


def portfolio_method(invstr)
    invstr.all_positions
    gets
end

def display_broker_info(invstr)
    puts invstr.get_broker_contact
    gets
end

def deposit_method(invstr)
    puts "\n\n\n\n\n\n"
    print "          How much would you like to deposit today?:  "
    amount = gets.chomp
    invstr.add_cash(amount)
    gets
end

def withdraw_method(invstr)
    puts "\n\n\n\n\n\n"
    print "          How much would you like to withdraw today?:  "
    amount = gets.chomp
    invstr.withdraw_cash(amount)
    gets
end

def direct_broker(invstr)
    puts "\n\n\n\n\n\n"
    print "          Would you like to buy or sell today?:  "
    cmd = gets.chomp

    case cmd
    when "buy" || "b"
        puts "\n\n\n"
        print "          What stock would you like to buy? (Please provide ticker):  "
        tckr = gets.chomp
        puts "\n\n\n"
        print "          How many shares would you like to buy?:  "
        qty = gets.chomp
        invstr.broker.buy_stock_for_investor(invstr.id, tckr, qty)
    when "sell"
        puts "\n\n\n"
        print "          What stock would you like to sell today? (Please provide ticker):  "
        tckr = gets.chomp
        puts "\n\n\n"
        print "          How many shares would you like to sell?:  "
        qty = gets.chomp
        invstr.broker.sell_stock_for_investor(invstr.id, tckr, qty)
    when "cancel"
        print "Request cancelled."
    else
        print "Invalid Command."
        gets
        direct_broker(invstr)
    end
    gets
end

def launch_investor_interface(invstr)
    while true
        system("clear")
        puts "\n\n\n\n\n\n"
        puts "          Please type a command for PetS to execute"
        puts "          If you are unsure, enter h or help for your options"
        input = gets.chomp

        case input
        when "help" || "h"
            puts ""
            investor_help
        when "q" || "quit"
            logout
            break
        when "quote" #print a position of a single equity that i own
            puts "          Do you know the company ticker?"
            tckr = gets.chomp
            quote(invstr, tckr)

        when "portfolio"
            portfolio_method(invstr)

        when "deposit"
            deposit_method
        when "withdraw" || "get money"
            withdraw_method
        when "broker" || "b"
            display_broker_info(invstr)
        when "trade"
            direct_broker
        else
            puts "          I don't recognize that command!"
            puts "          Here's a bit of help!"
            investor_help
        end




    end

    # command_hash = {"help" => investor_help, "h" => investor_help, "q" => logout}
    # command_hash[input]


    #help
    #logout
    #print a position of a single equity that i own
    #print all positions
    #deposit and withdraw (monopoly money!)
    #broker inquiry
    #direct broker to action


end
