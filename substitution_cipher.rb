module SubstitutionCipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String

    def self.encrypt(document, key)
      document = document.to_s
      alphabet = Array(' '..'~')
      encrypter = Hash[alphabet.zip(alphabet.rotate(key))]
      document.chars.map { |c| encrypter.fetch(c, ' ') }.join
    end
    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String

    def self.decrypt(document, key)
      document = document.to_s
      alphabet = Array(' '..'~')
      encrypter = Hash[alphabet.zip(alphabet.rotate(-key))]
      document.chars.map { |c| encrypter.fetch(c, ' ') }.join
    end
  end

  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      ascii_arr = (0..127).to_a.shuffle(random: Random.new(key))
      str_arr = document.to_s.chars.map(&:ord)
      str_arr.map! { |s| ascii_arr.index(s).chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      ascii_rand = (0..127).to_a.shuffle(random: Random.new(key))
      str_arr = document.chars.map(&:ord)
      str_arr.map! { |n| ascii_rand[n].chr }.join
    end
  end
end
