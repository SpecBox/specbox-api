class Avram::Join::MultiLeft < Avram::Join::SqlClause
  @from_keys : Array(Symbol) = [] of Symbol

  def set_from_keys(@from_keys : Array(Symbol))
  end

  def to_sql : String
    String.build do |io|
      io << "#{join_type} JOIN "
      @to.to_s(io)
      if @alias_to
        io << " AS #{@alias_to}"
      end
      from_key_cands = "ON COALESCE(#{@from_keys.map { |col| "\"#{from}\".\"#{col}\"" }.join(", ")})"
      io << " #{from_key_cands} #{@comparison} #{to_column}"
    end
  end

  def join_type : String
    "LEFT"
  end
end
