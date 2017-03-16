require 'Matrix'

# This library can encrypt and decrypt using DoubleTransposition method
module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext
    stringify = document.to_s
    r_c = compute_number_of_rows_cols(stringify)
    origin_m = Matrix.build(r_c[0], r_c[1]).with_index { |_, i| stringify[i] }
    # Generating Keys
    row_key = (1..r_c[0]).to_a.shuffle(random: Random.new(key))
    col_key = (1..r_c[1]).to_a.shuffle(random: Random.new(key + 1))
    # Encrypt with keys
    Matrix.build(r_c[0], r_c[1]) do |row, col|
      value = origin_m.row(row_key[row] - 1)[col_key[col] - 1]
      value.nil? ? ' ' : value
    end.to_a.join
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    r_c = compute_number_of_rows_cols(ciphertext)
    enc_m = Matrix.build(r_c[0], r_c[1]).with_index { |_, i| ciphertext[i] }
    # Generating Keys
    key_row = (1..r_c[0]).to_a.shuffle(random: Random.new(key))
    key_col = (1..r_c[1]).to_a.shuffle(random: Random.new(key + 1))
    # Generate Decrypt Keys
    d_key_row = [], d_key_col = []
    key_row.each_with_index { |value, i| d_key_row[value - 1] = i + 1 }
    key_col.each_with_index { |value, i| d_key_col[value - 1] = i + 1 }
    # Decrypt with keys
    Matrix.build(r_c[0], r_c[1]) do |row, col|
      enc_m.row(d_key_row[row] - 1)[d_key_col[col] - 1]
    end.to_a.join.strip
  end

  def self.compute_number_of_rows_cols(stringify)
    a = Math.sqrt(stringify.length)
    num_row = stringify.length <= a.ceil * (a.ceil - 1) ? a.ceil - 1 : a.ceil
    num_col = a.ceil
    [num_row, num_col]
  end
end
