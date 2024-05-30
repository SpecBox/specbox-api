class EnableCitext::V20231130193843 < Avram::Migrator::Migration::V1
  def migrate
    enable_extension "citext"
  end

  def rollback
    disable_extension "citext"
  end
end
