require "iso_codes"

module Countries
  @@all_alpha_2 : Array(String) = ISOCodes.countries.map(&.alpha_2)

  def self.all_alpha_2
    @@all_alpha_2
  end
end
