# コレクション設定の保存オペレーション
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
    # ASCIIのみ許可
    validate_format_of collection_name, with: /^[!-~ ]+$/
    validate_size_of institution_code, max: 10
    # ASCIIのみ許可
    validate_format_of institution_code, with: /^[!-~ ]+$/
    validate_numeric latest_collection_code, at_least: 0
    validate_numeric latest_collection_code, no_more_than: 999999999999999999i64
    validate_size_of note, max: 200
  end
end
