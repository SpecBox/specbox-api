# 全ユーザーに共有されるデフォルト分類情報
class DefaultTaxon < BaseModel
  skip_default_columns
  table :default_taxa do
    # all_taxaの対応するレコードと同じID
    primary_key taxon_ptr_id : UUID
    column is_private : Bool = false
  end
end
