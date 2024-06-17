module ValidationRegex
  @@ascii = /^[!-~ ]+$/

  def self.ascii
    @@ascii
  end
end
