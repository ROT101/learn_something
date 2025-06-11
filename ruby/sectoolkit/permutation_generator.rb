module SecToolKit
  class PermutationGenerator
    require "set"

    def self.generate(base_string, min_length: 1, max_length: nil, limit: nil)
      max_length ||= base_string.length
      
      # Handle empty string case first
      return [] if base_string.empty?
      
      # Validate lengths after empty string check
      if min_length > max_length
        raise ArgumentError, "min_length (#{min_length}) must be <= max_length (#{max_length})"
      end
      if min_length <= 0
        raise ArgumentError, "min_length must be positive"
      end

      results = Set.new
      (min_length..[max_length, base_string.length].min).each do |len|
        base_string.chars.permutation(len).each do |perm|
          results << perm.join
          return results.to_a.take(limit) if limit && results.size >= limit
        end
      end
      results.to_a
    end
  end
end