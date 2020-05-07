Investor.destroy_all
Broker.destroy_all
Transaction.destroy_all
Company.destroy_all

#Brokers

gb = Broker.find_or_create_by(first_name: "George", last_name: "Banks", username: "gbanks", password: "poppins", email: "gbanks@pets.com", telephone: "777-555-7654")
burns = Broker.find_or_create_by(first_name: "Montgomery", last_name: "Burns", username: "mtburns", password: "springfield", email: "mtburns@pets.com", telephone: "818-404-9009")
pn = Broker.find_or_create_by(first_name: "Paul", last_name: "Nicholsen", username: "pnicholsen", password: "iluvcats", email: "pnicholsen@pets.com", telephone: "202-555-7654")
sn = Broker.find_or_create_by(first_name: "Shannon", last_name: "Nabors", username: "snabors", password: "pictionary", email: "snbabors@pets.com", telephone: "202-555-0798")

#Investors - classmates and Nic Cage

epb = Investor.find_or_create_by(first_name: "Enrique", last_name: "Pittaluga", username: "epittab", password: "hunter2", account_cash: 10000.0)
agds = Investor.find_or_create_by(first_name: "Davis", last_name: "Sargeant", username: "agdsarge", password: "30rock", account_cash: 10000.0)
jfk = Investor.find_or_create_by(first_name: "Jack", last_name: "Kennedy", username: "jfk", password: "bay_of_pigs", account_cash: 10000.0)
jma = Investor.find_or_create_by(first_name: "Jack", last_name: "Ma", username: "jma", password: "alibaba", account_cash: 10000.0)
nic = Investor.find_or_create_by(first_name: "Nic", last_name: "Cage", username: "ncage", password: "national_treasure", account_cash: 25)
as = Investor.find_or_create_by(first_name: "Abhinav", last_name: "Sharma", username: "asharma", password: "itilapp", account_cash: 10000.0)
ag = Investor.find_or_create_by(first_name: "Alex", last_name: "Gautherin", username: "agautherin", password: "discord", account_cash: 10000.0)
injae = Investor.find_or_create_by(first_name: "Enrique", last_name: "Pittaluga", username: "epittab", password: "hunter2", account_cash: 10000.0)
mert
jl
jb
sa
#

jfk.broker_id = burns.id
jma.broker_id = burns.id

epb.broker_id = gb.id
agds.broker_id = gb.id
nic.broker_id = gb.id

nic.save
epb.save
agds.save
jfk.save
jma.save


#transactions (use dates from ~20 March, the valley. both purchases and sales)


aapl = Company.find_or_create_by(ticker: "AAPL", name: "Apple Inc.", current_price: 300.80)
bud = Company.find_or_create_by(ticker: "BUD", name: "Anheuser-Busch InBev SA/NV", current_price: 41.69)
cmg = Company.find_or_create_by(ticker: "CMG", name: "Chipotle Mexican Grill, Inc.", current_price: 876.25)
jnj = Company.find_or_create_by(ticker: "JNJ", name: "Johnson & Johnson", current_price: 150.28)
mmm = Company.find_or_create_by(ticker: "MMM", name:"3M Company", current_price: 148.50)
mrk = Company.find_or_create_by(ticker: "MRK", name: "Merck & Co., Inc.", current_price: 78.70)
pzza = Company.find_or_create_by(ticker: "PZZA", name: "Papa John's International, Inc.", current_price: 75.50)
sb = Company.find_or_create_by(ticker: "SBUX", name: "Starbucks Corporation", current_price: 74.14)
voo = Company.find_or_create_by(ticker: "VOO", name: "Vanguard S&P 500 ETF", current_price: 265.65)
wf = Company.find_or_create_by(ticker: "WFC", name: "Wells Fargo & Company", current_price: 26.65)


# Initialize some transactions using back dated stocks (march 20th, 2020 ish). Gotta show gains.
epb.buy_stock("aapl", 10)
epb.buy_stock("aapl", 20)
epb.sell_stock("aapl", 5)
epb.buy_stock("aapl", 2)
epb.buy_stock("mmm", 20)


agds.buy_stock("cmg", 10)
agds.buy_stock("jnj", 20)
agds.sell_stock("jnj", 5)
agds.buy_stock("voo", 2)
agds.buy_stock("sbux", 20)
