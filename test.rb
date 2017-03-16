module DoubleTranspositionCipher
  def encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext
    stringify = document.to_s
    a = Math.sqrt(stringify.length)
    if stringify.length < a.ceil * (a.ceil - 1)
      row = a.ceil
      col = a.ceil - 1
    else
      row = a.ceil
      col = a.ceil
    end
    stringify = stringify.chars
    m = Matrix.build(row, col).with_index {|n,i| stringify[i]}
    row_rand=(1..row).to_a.shuffle(random: Random.new(key))
    col_rand=(1..col).to_a.shuffle(random: Random.new(key+1))
    aa = Matrix.build(row, col) do |row,col|
      m.row(row_rand[row]-1)[col_rand[col]-1]
    end
    return aa.to_a.join
  end

  def decrypt(ciphertext, key)
    a = Math.sqrt(ciphertext.length)
    if ciphertext.length < a.ceil * (a.ceil - 1)
      row = a.ceil
      col = a.ceil - 1
    else
      row = a.ceil
      col = a.ceil
    end
    stringify = ciphertext.chars
    row_rand=(1..row).to_a.shuffle(random: Random.new(key))
    col_rand=(1..col).to_a.shuffle(random: Random.new(key+1))
    aa = Matrix.build(row, col) do |row,col|
      r = row_rand.find_index(row+1)
      c = col_rand.find_index(col+1)
      stringify[(r+1)*(c+1)+(r+1)]
    end
    return aa.to_a.join
  end
end


t=encrypt(document, key)
f=decrypt(t, key)
