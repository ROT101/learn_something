module SecToolKit
  class Pipeline
    def self.run_password_pipeline(length , hash_algorithm , archive_path , archive_password)
      password = PasswordGenerator.generate(length)
      hashed = Hasher.digest(password,hash_algorithm)
      temp_file = "temp_password.txt"
      File.write(temp_file, hashed)
      puts "password:#{password}"

      Archiver.compress(temp_file, archive_path, archive_password)
      File.delete(temp_file)

      {
        password: password,
        hash: hashed,
        archive: archive_path
      }
    end

    def self.run_encode_then_encrypt(input_string, format:, encryption_password:, cipher: "AES-256-CBC")
      encoded = EncoderDecoder.encode(input_string, format)
      encrypted = Encryptor.encrypt(encoded, encryption_password, cipher: cipher)
      encrypted
    end

    def self.run_decrypt_then_decode(encrypted_payload, encryption_password:, format:)
      decrypted = Encryptor.decrypt(encrypted_payload, encryption_password)
      decoded = EncoderDecoder.decode(decrypted, format)
      decoded
    end

    def self.decrypt_and_extract(archive_path, output_dir, archive_password: nil)
      Archiver.decompress(archive_path, output_dir, password: archive_password)
    end
  end
end
