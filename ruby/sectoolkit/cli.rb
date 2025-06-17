require "thor"

module SecToolKit
  class Cli < Thor

    def self.exit_on_failure?
      false
    end
    
    desc "generate_password LENGTH", "Generate a secure password"
    def generate_password(length)
      puts PasswordGenerator.generate(length: length.to_i)
    end

    desc "hash STRING ALGORITHM", "Generate a hash from a string"
    def hash(string, algorithm)
      puts Hasher.digest(string, algorithm: algorithm)
    end

    desc "encode STRING FORMAT", "Encode a string (formats: base64, hex, binary, uri)"
    def encode(string, format)
      puts EncoderDecoder.encode(string, format)
    end

    desc "decode STRING FORMAT", "Decode a string (formats: base64, hex, binary, uri)"
    def decode(string, format)
      puts EncoderDecoder.decode(string, format)
    end

    desc "encrypt STRING PASSWORD CIPHER", "Encrypt a string"
    def encrypt(string, password, cipher = "AES-256-CBC")
      puts Marshal.dump(Encryptor.encrypt(string, password, cipher: cipher))
    end

    desc "decrypt FILE PASSWORD", "Decrypt a marshaled encrypted file"
    def decrypt(file_path, password)
      encrypted = Marshal.load(File.read(file_path))
      puts Encryptor.decrypt(encrypted, password)
    end

    desc "archive INPUT_PATH OUTPUT_PATH [PASSWORD]", "Compress and optionally encrypt"
    def archive(input, output, password = nil)
      Archiver.compress(input, output, password: password)
      puts "Archived to #{output}"
    end

    desc "extract ARCHIVE OUTPUT_DIR [PASSWORD]", "Extract and optionally decrypt"
    def extract(archive, output_dir, password = nil)
      Archiver.decompress(archive, output_dir, password: password)
      puts "Extracted to #{output_dir}"
    end

    desc "man", "Display full usage manual"
    def man
      puts File.read(File.expand_path("../../../man/manual.md", __FILE__))
    end

    desc "help", "Show help"
    def help(*args)
      super
    end
  end
end
