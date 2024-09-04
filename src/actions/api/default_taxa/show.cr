# デフォルト分類情報のID指定取得API
class Api::DefaultTaxa::Show < ApiAction
  get "/api/default-taxa/:record_id" do
    record = TaxonQuery.new.only_default_taxon.find(record_id)
    json TaxonSerializer.nested_key_data(record)
  end
end
