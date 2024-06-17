macro switch_avram_nothing_for_serialize_class(*attrs)
  {% for attr in attrs %}
    def {{attr}}__for_avram
      @{{attr}}.nil? ? Avram::Nothing.new : @{{attr}}.not_nil!
    end
  {% end %}
end
