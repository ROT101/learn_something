require "fileutils"
require "zlib"
require "archive/tar/minitar"
require "digest"

module SecToolKit
  class Archiver
    include Archive::Tar

    # Compress and optionally password-protect a folder or file.
    def self.compress(input_path, output_path, password: nil)
      raise "Input path not found" unless File.exist?(input_path)
      tar_path = output_path.sub(/\.gz$/, "")

      File.open(tar_path, "wb") do |tar|
        Minitar.pack(input_path, tar)
      end

      Zlib::GzipWriter.open(output_path) do |gz|
        File.open(tar_path, "rb") { |f| gz.write(f.read) }
      end

      File.delete(tar_path) if File.exist?(tar_path)

      if password
        encrypted = SecToolKit::Encryptor.encrypt(File.read(output_path), password)
        File.write(output_path, Marshal.dump(encrypted))
      end
    end

    # Decompress and optionally decrypt an archive.
    def self.decompress(archive_path, output_dir, password: nil)
      content = File.read(archive_path)

      if password
        encrypted = Marshal.load(content)
        content = SecToolKit::Encryptor.decrypt(encrypted, password)
        File.write("#{archive_path}.tmp", content)
        archive_path = "#{archive_path}.tmp"
      end

      Zlib::GzipReader.open(archive_path) do |gz|
        Minitar.unpack(gz, output_dir)
      end

      File.delete("#{archive_path}.tmp") if password && File.exist?("#{archive_path}.tmp")
    end
  end
end

