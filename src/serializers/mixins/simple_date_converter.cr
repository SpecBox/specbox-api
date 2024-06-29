module SimpleDateConverter
  @@simple_date_converter = Time::Format.new("%Y-%m-%d")

  def self.simple_date_converter
    @@simple_date_converter
  end
end
