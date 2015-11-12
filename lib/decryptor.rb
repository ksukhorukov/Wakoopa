require 'base64'
require 'zlib'

module Decryptor

  def self.inflate(string)
    zstream = Zlib::Inflate.new
    buf = zstream.inflate(string)
    zstream.finish
    zstream.close
    buf
  end

  def self.normalize(string)
    inflate(Base64.decode64(string))
  end

end