class SaveCollectionSetting < CollectionSetting::SaveOperation
  # To save user provided params to the database, you must permit them
  # https://luckyframework.org/guides/database/saving-records#perma-permitting-columns
  #
  # permit_columns column_1, column_2
  permit_columns(
    collection_name,
    institution_code,
    latest_collection_code,
    note
  )

  before_save do
    validate_size_of collection_name, max: 174
    validate_size_of institution_code, max: 10
    validate_numeric latest_collection_code, less_than: 999999999999999999i64
  end
end
