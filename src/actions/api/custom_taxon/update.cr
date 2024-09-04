# カスタム分類情報の更新API
class Api::CustomTaxa::Update < ApiAction
  put "/api/custom-taxa/:id" do
    record = TaxonQuery.new.only_custom_taxon.only_current_user(current_user.id).find(id)
    SaveTaxon.update!(record, params)
    head 204
  end
end
