class Company < ActiveRecord::Base
    has_many :transactions
    has_many :investors, through: :transactions


end
