require_relative 'validate.rb'

hash = {:name => "Davis", :id => 12, :account_cash => 3.00 }
hash2 = {:name => "Davis", :id => 2, :account_cash => 3.00 }
hash3 = {:name => 239487, :id => 12, :account_cash => 3.00 }
hash4 = {:name => "239487", :id => 12, :account_cash => "3.00" }


puts Validation.validate?(hash)
gets
puts Validation.validate?(hash2)
gets
puts Validation.validate?(hash3)
gets
puts Validation.validate?(hash4)
