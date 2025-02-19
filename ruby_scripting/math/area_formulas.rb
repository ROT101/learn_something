#!/bin/env ruby
# area formulas
module Area

    @pi = 3.14
    
    def self.circle(r)
        return (@pi * r.pow(2))
    end

    def self.sphere(r)
        return (4 * @pi * r.pow(2))
    end

    def self.cylinder(r,h)
        return (2 * @pi * r * h)
    end 

    def self.cone(r,s)
        return (@pi * r * s)
    end
    def self.triangle(b,h)
        return (0.5 * b * h)
    end

    def self.rectangle(l,h)
        return (l * h)
    end

    def self.square(l)
        return l.pow(2)
    end

end 

r = 5
h = 8
b = 7
l = 4


puts Area::circle(r)
puts Area::sphere(r)
puts Area::cone(r,h)
puts Area::triangle(b,h)
puts Area::rectangle(l,h)
puts Area::square(l)

