# Doctor.destroy_all
# Hospital.destroy_all
# Patient.destroy_all
# DoctorPatient.destroy_all
#
# sacred_heart = Hospital.find_or_create_by(name: "Sacred Heart")
# county = Hospital.find_or_create_by(name: "County")
#
# jd = Doctor.find_or_create_by(name: "John Dorian", hospital: sacred_heart)
# turk = Doctor.find_or_create_by(name: "Chris Turk", hospital: sacred_heart)
# elliot = Doctor.find_or_create_by(name: "Elliot Reid", hospital: sacred_heart)
# doug = Doctor.find_or_create_by(name: "Doug Ross", hospital_id: county.id)
#
# mrs_wilke = Patient.find_or_create_by(name: "Mrs Wilke")
# johnny = Patient.find_or_create_by(name: "Johnny the Tackling Alzheimers Patient")
#
# mrs_wilke.doctors << jd
# jd.patients << johnny
# turk.patients << mrs_wilke
#
# # DoctorPatient.new(doctor: jd, patient: mrs_wilke)

Investor.destroy_all
Broker.destroy_all
Transaction.destroy_all
Company.destroy_all

gb = Broker.find_or_create_by(first_name: "George", last_name: "Banks", username: "gbanks", password: "poppins", email: "gbanks@pets.com", telephone: "777-555-7654")

epb = Investor.find_or_create_by(first_name: "Enrique", last_name: "Pittaluga", username: "epittab", password: "hunter2")
agds = Investor.find_or_create_by(first_name: "Davis", last_name: "Sargeant", username: "agdsarge", password: "30rock")

epb.broker_id = gb.id
agds.broker_id = gb.id

bud = Company.find_or_create_by(ticker: "BUD", name: "Anheuser-Busch InBev SA/NV", current_price: 41.69)
mrk = Company.find_or_create_by(ticker: "MRK", name: "Merck & Co., Inc.", current_price: 78.70)
pzza = Company.find_or_create_by(ticker: "PZZA", name: "Papa John's International, Inc.", current_price: 75.50)
jnj = Company.find_or_create_by(ticker: "JNJ", name: "Johnson & Johnson", current_price: 150.28)
cmg = Company.find_or_create_by(ticker: "CMG", name: "Chipotle Mexican Grill, Inc.", current_price: 876.25)
voo = Company.find_or_create_by(ticker: "VOO", name: "Vanguard S&P 500 ETF", current_price: 265.65)
sb = Company.find_or_create_by(ticker: "SBUX", name: "Starbucks Corporation", current_price: 74.14)
wf = Company.find_or_create_by(ticker: "WFC", name: "Wells Fargo & Company", current_price: 26.65)
mmm = Company.find_or_create_by(ticker: "MMM", name:"3M Company", current_price: 148.50)
aapl = Company.find_or_create_by(ticker: "AAPL", name: "Apple Inc.", current_price: 300.80)
