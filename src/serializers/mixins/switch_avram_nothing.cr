macro switch_avram_nothing_for_serialize_class(attr)
  def {{attr}}__for_avram
    @{{attr}}.nil? ? Avram::Nothing.new : @{{attr}}.not_nil!
  end
end
