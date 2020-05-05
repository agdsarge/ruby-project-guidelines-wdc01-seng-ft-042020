class Investor < ActiveRecord::Base
    has_many :transactions
    has_many :companies, through: :transactions
    belongs_to :broker




end
