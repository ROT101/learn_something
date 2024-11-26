#!/usr/bin/env ruby

def caesar_cipher(text, shift)
  encrypted_text = ''

  text.each_char do |char|
    if char =~ /[A-Za-z]/ # Check if the character is a letter
      base = char.ord < 91 ? 'A'.ord : 'a'.ord
      encrypted_char = ((char.ord - base + shift) % 26 + base).chr
      encrypted_text += encrypted_char
    elsif char =~ /[0-9]/ # Check if the character is a digit
      encrypted_char = ((char.ord - '0'.ord + shift) % 10 + '0'.ord).chr
      encrypted_text += encrypted_char
    else
      encrypted_text += char # Non-alphanumeric characters remain unchanged
    end
  end

  encrypted_text
end

def decrypt_caesar_cipher(text, shift)
  caesar_cipher(text, -shift)
end

# Main execution
if ARGV.length < 3
  puts "Usage: ruby caesar_cipher.rb <encrypt|decrypt> <shift> <text>"
  exit 1
end

operation = ARGV[0].downcase
shift = ARGV[1].to_i
text = ARGV[2..-1].join(' ')

if shift < 1 || shift > 30
  puts "Shift must be between 1 and 30."
  exit 1
end

case operation
when 'encrypt'
  encrypted_text = caesar_cipher(text, shift)
  puts "Encrypted: #{encrypted_text}"
when 'decrypt'
  decrypted_text = decrypt_caesar_cipher(text, shift)
  puts "Decrypted: #{decrypted_text}"
else
  puts "Invalid operation. Use 'encrypt' or 'decrypt'."
end
