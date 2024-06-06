# コレクション設定レコードのテストデータ
class CollectionSettingFactory < Avram::Factory
  def initialize
    id UUID.random
    user_id AuthUserFactory.create.id
    collection_name "TEST COLLECTION"
    institution_code "TSC"
    latest_collection_code 0
    note ""
  end
end
