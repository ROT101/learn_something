require "openssl"
require "base64"

module SecToolKit
  # Encrypts and decrypts data using OpenSSL ciphers.
  class Encryptor
    SUPPORTED_CIPHERS = ["AES-256-CBC", "AES-128-CBC", "ChaCha20"]

    def self.encrypt(data, password, cipher: "AES-256-CBC")
      raise ArgumentError, "Unsupported cipher: #{cipher}" unless SUPPORTED_CIPHERS.include?(cipher)

      cipher_obj = OpenSSL::Cipher.new(cipher)
      cipher_obj.encrypt
      salt = OpenSSL::Random.random_bytes(16)
      iv = cipher_obj.random_iv
      key = OpenSSL::PKCS5.pbkdf2_hmac(password, salt, 2000, cipher_obj.key_len, "SHA256")

      cipher_obj.key = key
      cipher_obj.iv = iv
      encrypted = cipher_obj.update(data) + cipher_obj.final

      {
        iv: Base64.encode64(iv),
        salt: Base64.encode64(salt),
        data: Base64.encode64(encrypted),
        cipher: cipher
      }
    end

    def self.decrypt(payload, password)
      cipher = payload[:cipher]
      raise ArgumentError, "Unsupported cipher: #{cipher}" unless SUPPORTED_CIPHERS.include?(cipher)

      cipher_obj = OpenSSL::Cipher.new(cipher)
      cipher_obj.decrypt

      salt = Base64.decode64(payload[:salt])
      iv = Base64.decode64(payload[:iv])
      encrypted = Base64.decode64(payload[:data])

      key = OpenSSL::PKCS5.pbkdf2_hmac(password, salt, 2000, cipher_obj.key_len, "SHA256")

      cipher_obj.key = key
      cipher_obj.iv = iv

      cipher_obj.update(encrypted) + cipher_obj.final
    end
  end
end