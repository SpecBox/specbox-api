# デフォルト分類情報のID指定取得API
class Api::DefaultTaxa::Show < ApiAction
  get "/api/default-taxa/:record_id" do
    record = DefaultTaxonQuery.new.find(record_id)
    taxon = TaxonQuery.new.find(record.taxon_ptr_id)
    json TaxonSerializer.nested_key_data(taxon)
  end
end
