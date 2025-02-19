#/bin/env ruby

#finding the prime and composite
# set the test number 
num = 97
# set the a range from 1 to the test number
range = (1..num)
#create an array 
factors = []

# block to iterate from 1 to the test number
range.each do |p|
    # test if the numbers in range are a factor the test number
    if num%p == 0
        # push the factors of the test number into array  
        factors << p
    end
end
  
puts "foactors of #{num}: #{factors.join(" ")}"
# test if the size of the array is less than or equal to 2 
if factors.size <= 2
    puts "#{num} is a prime "
else
    puts "#{num} is a composite"
    
end
