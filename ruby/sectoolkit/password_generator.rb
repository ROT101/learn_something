require "securerandom"
module SecToolKit
  # Generates cryptographically secure random passwords.
  class PasswordGenerator
    DEFAULT_LENGTH = 16
    MIN_LENGTH = 8
    MAX_LENGTH = 64

    CHARACTER_SETS = {
      lowercase: ('a'..'z').to_a,
      uppercase: ('A'..'Z').to_a,
      digits:    ('0'..'9').to_a,
      symbols:   %w[! @ # $ % ^ & * - _ + = ?]
    }

    # Generate a secure random password.
    #
    # @param length [Integer] Length of password (8 to 64)
    # @param use_sets [Array<Symbol>] Character sets to include
    # @return [String] Generated password
    def self.generate(length: DEFAULT_LENGTH, use_sets: [:lowercase, :uppercase, :digits, :symbols])
      raise ArgumentError, "ARGUMENTERROR Length must be between #{MIN_LENGTH} and #{MAX_LENGTH}" unless length.between?(MIN_LENGTH, MAX_LENGTH)

      chars = use_sets.flat_map { |set| CHARACTER_SETS[set] || [] }
      raise ArgumentError, "No valid character sets selected" if chars.empty?

      password = Array.new(length) { chars.sample(random: SecureRandom) }.join
      password
    end
  end
end
