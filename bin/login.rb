
def validate_pair(uname, pword)
    inv = Investor.where("username = ? AND password = ?", uname, pword )
    bro = Broker.where("username = ? AND password = ?", uname, pword )

    if inv.length > 0
        return inv[0]
    elsif bro.length > 0
        return bro[0]
    else
        puts "Invalid username or password. Please try again."
        gets; login
    end

end

def login
    system("clear")
    puts "\n\n\n\n\n\n"
    puts "          Welcome to Pittaluga et Sargeant LP."
    print "          Please enter your username:   "
    username = gets.chomp
    print "          Please enter your password:   "
    password = gets.chomp
    puts "\n\n"
    x = validate_pair(username, password)
    puts "           It's good to see you again, #{x.first_name}"
    puts "\n\n"
    gets
    return x

end
