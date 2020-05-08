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
injae = Investor.find_or_create_by(first_name: "Injae", last_name: "Lee", username: "ilee", password: "pedicab", account_cash: 10000.0)
mert = Investor.find_or_create_by(first_name: "Mert", last_name: "Ozkaynak", username: "mozkaynak", password: "basketball", account_cash: 10000.0)
jl = Investor.find_or_create_by(first_name: "Jesse", last_name: "Langley", username: "jlangley", password: "mclaren", account_cash: 10000.0)
jb = Investor.find_or_create_by(first_name: "Josh", last_name: "Beglan", username: "jbeglan", password: "fenway", account_cash: 10000.0)
sa = Investor.find_or_create_by(first_name: "Saima", last_name: "Akhtar", username: "sakhtar", password: "architecture", account_cash: 10000.0)
#

jfk.broker_id = burns.id
jma.broker_id = burns.id

epb.broker_id = gb.id
agds.broker_id = gb.id
nic.broker_id = gb.id

as.broker_id = pn.id
ag.broker_id = sn.id
injae.broker_id = pn.id
mert.broker_id = sn.id
jl.broker_id = pn.id
jb.broker_id = sn.id
sa.broker_id = pn.id

as.save
ag.save
injae.save
mert.save
jl.save
jb.save
sa.save

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

Transaction.create(investor_id: ag.id, company_id: aapl.id, transaction_date: DateTime.new(2020, 3, 20, 0, 0, 0), price: 229.24, quantity: 1, is_purchase?: true)
Transaction.create(investor_id: as.id, company_id: bud.id, transaction_date: DateTime.new(2020, 3, 20, 0, 0, 0), price: 40.30, quantity: 1, is_purchase?: true)
Transaction.create(investor_id: injae.id, company_id: cmg.id, transaction_date: DateTime.new(2020, 3, 20, 0, 0, 0), price: 566.0, quantity: 1, is_purchase?: true)
Transaction.create(investor_id: mert.id, company_id: jnj.id, transaction_date: DateTime.new(2020, 3, 20, 0, 0, 0), price: 119.89, quantity: 1, is_purchase?: true)
Transaction.create(investor_id: jl.id, company_id: mmm.id, transaction_date: DateTime.new(2020, 3, 20, 0, 0, 0), price: 124.89, quantity: 1, is_purchase?: true)
Transaction.create(investor_id: jb.id, company_id: mrk.id, transaction_date: DateTime.new(2020, 3, 20, 0, 0, 0), price: 71.36, quantity: 1, is_purchase?: true)
Transaction.create(investor_id: sa.id, company_id: pzza.id, transaction_date: DateTime.new(2020, 3, 20, 0, 0, 0), price: 51.0, quantity: 1, is_purchase?: true)
