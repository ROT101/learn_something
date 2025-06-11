require "digest"


module SecToolKit
  # Supports multiple hashing algorithms.
  class Hasher
    SUPPORTED_ALGORITHMS = {
      "md5"    => ->(data) { Digest::MD5.hexdigest(data) },
      "sha1"   => ->(data) { Digest::SHA1.hexdigest(data) },
      "sha256" => ->(data) { Digest::SHA256.hexdigest(data) },
      "sha384" => ->(data) { Digest::SHA384.hexdigest(data) },
      "sha512" => ->(data) { Digest::SHA512.hexdigest(data) }
    }.freeze

    # Hash a string or file content.
    #
    # @param input [String] Raw string or file path.
    # @param algorithm [String] Hashing algorithm.
    # @param file [Boolean] Whether the input is a file path.
    # @return [String] Hash digest.
    # @raise [RuntimeError] If algorithm is unsupported.
    def self.digest(input, algorithm: "sha256", file: false)
      algorithm_key = algorithm.downcase
      unless SUPPORTED_ALGORITHMS.key?(algorithm_key)
        raise RuntimeError, "Unsupported algorithm #{algorithm}"
      end

      data = file ? File.read(input) : input
      SUPPORTED_ALGORITHMS[algorithm_key].call(data)
    end
  end
end