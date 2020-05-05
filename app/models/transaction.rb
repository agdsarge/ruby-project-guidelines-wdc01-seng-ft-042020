class Transaction < ActiveRecord::Base
    belongs_to :investor
    belongs_to :company

end
