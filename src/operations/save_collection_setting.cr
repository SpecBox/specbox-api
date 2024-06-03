class SaveCollectionSetting < CollectionSetting::SaveOperation
  permit_columns(
    id,
    collection_name,
    institution_code,
    latest_collection_code,
    note,
    user_id
  )

  before_save do
    validate_size_of collection_name, max: 174
    validate_size_of institution_code, max: 10
    validate_numeric latest_collection_code, no_more_than: 999999999999999999i64
  end
end
