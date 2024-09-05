# カスタム分類情報のID指定取得API
class Api::CustomTaxa::Show < ApiAction
  get "/api/custom-taxa/:record_id" do
    record = TaxonQuery.new.only_custom_taxon.only_current_user(current_user.id).find(record_id)
    json TaxonSerializer.nested_key_data(record)
  end
end
