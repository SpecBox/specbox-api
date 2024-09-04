# カスタム分類情報の削除API
class Api::CustomTaxa::Delete < ApiAction
  delete "/api/custom-taxa/:record_id" do
    record = CustomTaxonQuery.new.user_id(current_user.id).find(record_id)
    taxon_record = TaxonQuery.new.find(record.taxon_ptr_id)
    DeleteCustomTaxon.delete!(record)
    DeleteTaxon.delete!(taxon_record)
    head 204
  end
end
