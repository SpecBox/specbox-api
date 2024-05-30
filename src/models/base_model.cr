abstract class BaseModel < Avram::Model
  def self.database : Avram::Database.class
    AppDatabase
  end

  macro default_columns
    primary_key custom_key : UUID
    timestamps
  end
end
