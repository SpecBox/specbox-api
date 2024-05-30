class EnablePostGis::V20231130194235 < Avram::Migrator::Migration::V1
  def migrate
    enable_extension "postgis"
  end

  def rollback
    disable_extension "postgis"
  end
end
