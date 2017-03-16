require 'Matrix'
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
    a = Math.sqrt(stringify.length)
    num_row = stringify.length <= a.ceil * (a.ceil - 1) ? a.ceil - 1 : a.ceil
    num_col = a.ceil
    origin_m = Matrix.build(num_row, num_col).with_index { |_, i| stringify[i] }
    # Generating Keys
    row_key = (1..num_row).to_a.shuffle(random: Random.new(key))
    col_key = (1..num_col).to_a.shuffle(random: Random.new(key + 1))
    # Encrypt with keys
    enc_m = Matrix.build(num_row, num_col) do |row, col|
      origin_m.row(row_key[row] - 1)[col_key[col] - 1]
    end
    enc_m.to_a.join
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    a = Math.sqrt(ciphertext.length)
    numof_r = ciphertext.length <= a.ceil * (a.ceil - 1) ? a.ceil - 1 : a.ceil
    numof_c = a.ceil
    enc_m = Matrix.build(numof_r, numof_c).with_index { |_, i| ciphertext[i] }
    # Generating Keys
    key_row = (1..numof_r).to_a.shuffle(random: Random.new(key))
    key_col = (1..numof_c).to_a.shuffle(random: Random.new(key + 1))
    # Generate Decrypt Keys
    d_key_row = []
    d_key_col = []
    key_row.each_with_index { |value, i| d_key_row[value - 1] = i + 1 }
    key_col.each_with_index { |value, i| d_key_col[value - 1] = i + 1 }
    # Decrypt with keys
    dec_m = Matrix.build(numof_r, numof_c) do |row, col|
      enc_m.row(d_key_row[row] - 1)[d_key_col[col] - 1]
    end
    dec_m.to_a.join
  end
end
