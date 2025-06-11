require "base64"
require "uri"

module SecToolKit
  # Handles encoding and decoding in multiple formats.
  class EncoderDecoder
    SUPPORTED_ENCODINGS = %w[base64 hex binary uri]

    def self.encode(input, format)
      case format.downcase
      when "base64"
        Base64.strict_encode64(input)
      when "hex"
        input.unpack1("H*")
      when "binary"
        input.unpack1("B*")
      when "uri"
        URI.encode_www_form_component(input)
      else
        raise ArgumentError, "Unsupported encoding format: #{format}"
      end
    end

    def self.decode(input, format)
      case format.downcase
      when "base64"
        Base64.decode64(input)
      when "hex"
        [input].pack("H*")
      when "binary"
        [input].pack("B*")
      when "uri"
        URI.decode_www_form_component(input)
      else
        raise ArgumentError, "Unsupported decoding format: #{format}"
      end
    end
  end
end