#!/bin/env ruby

#list natural numbers and add them all together

#set the sum variable value to 0
sum = 0
# set the range limit  
set = (1..1999)
# set the the value to test agains  
multi_of = 15
# set the variable to an empty array
arr = []

# block to iterate through the range
set.each do |num|
    # test if the number is a factor of the test value
    if num%multi_of == 0
        # push factors of the test value into the array
        arr << num 
        # reset the sum variable value by adding the next factor of the test number
        sum += num    
    end
end

print "natural numbers that are the multiple of #{multi_of} between #{set} is:\n\n"
puts arr.join(" ")
puts "\nsum of natural numbers that are the multiple of #{multi_of} between #{set} is: #{sum}"