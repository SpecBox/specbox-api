module ValidationRegex
  @@ascii = /^[!-~ ]*$/
  @@ascii_and_accent = /^[!-~ À-ÖØ-öø-ÿāīūēōȳĀĪŪĒŌȲ]*$/

  def self.ascii
    @@ascii
  end

  def self.ascii_and_accent
    @@ascii_and_accent
  end
end
