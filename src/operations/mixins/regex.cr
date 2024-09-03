module ValidationRegex
  @@ascii = /^[!-~ ]*$/
  @@ascii_and_accent = /^[!-~ À-ÖØ-öø-ÿāīūēōȳĀĪŪĒŌȲ]*$/
  @@sentence_case_word = /^([A-Z]{1}[a-z]*){0,1}$/
  @@lower_case_word = /^[a-z-]*$/

  def self.ascii
    @@ascii
  end

  def self.ascii_and_accent
    @@ascii_and_accent
  end

  def self.sentence_case_word
    @@sentence_case_word
  end

  def self.lower_case_word
    @@lower_case_word
  end
end
