require 'rbnacl/libsodium'
require 'base64'

# Library for Symmetric Encrypting using Symmetric Cipher
module ModernSymmetricCipher
  def self.generate_new_key
    # TODO: Return a new key as a Base64 string
    key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
    Base64.encode64(key)
  end

  def self.encrypt(document, key)
    # TODO: Return an encrypted string
    #       Use base64 for ciphertext so that it is sendable as text
    simple_key = Base64.decode64(key)
    simplebox = RbNaCl::SimpleBox.from_secret_key(simple_key)
    ciphertext = simplebox.encrypt(document)
    Base64.encode64(ciphertext)
  end

  def self.decrypt(aes_crypt, key)
    # TODO: Decrypt from encrypted message above
    #       Expect Base64 encrypted message and Base64 key
    simple_key = Base64.decode64(key)
    ciphertext = Base64.decode64(aes_crypt)
    simplebox = RbNaCl::SimpleBox.from_secret_key(simple_key)
    simplebox.decrypt(ciphertext)
  end
end
