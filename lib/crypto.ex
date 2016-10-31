defmodule Crypto do
  @block_size_bits 128
  @block_size 16
  @padding 0
  @key :crypto.strong_rand_bytes(@block_size)
  @ivec :crypto.strong_rand_bytes(@block_size)

  def encrypt(text) do
    encrypt(text, <<>>)
  end

  def encrypt(<<>>, acc) do
    Base.encode64(acc)
  end

  def encrypt(<< n :: size(@block_size), rest :: binary >>, acc) do
    r = :crypto.block_encrypt(:aes_cbc128, @key, @ivec, << n :: size(@block_size) >>)
    encrypt(rest, << acc :: bitstring, r :: bitstring >>)
  end

  def encrypt(block, acc) do
    padding_size = @block_size - bit_size(block)
    padding = << @padding :: size(padding_size) >>
    block = <<block :: bitstring, padding :: bitstring>>
    encrypt(block, <<acc :: bitstring>>)
  end

  def decrypt(text) do
    decrypt(Base.decode64!(text), <<>>)
  end

  def decrypt(<<>>, acc) do
    acc
  end

  def decrypt(<< n :: size(@block_size), rest :: binary >>, acc) do
    r = :crypto.block_decrypt(:aes_cbc128, @key, @ivec, << n :: size(@block_size) >>)
    decrypt(rest, << acc :: bitstring, r :: bitstring >>)
  end

  def hash(text) do
  end
end
