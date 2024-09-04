# ユーザー定義のカスタム分類情報モデル
class CustomTaxon < BaseModel
  skip_default_columns
  table :custom_taxa do
    # all_taxaの対応するレコードと同じID
    primary_key taxon_ptr_id : UUID
    column is_private : Bool = true
    column user_id : Int32?
  end
end
