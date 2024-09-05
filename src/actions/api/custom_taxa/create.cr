# カスタム分類情報の作成API
class Api::CustomTaxa::Create < ApiAction
  post "/api/custom-taxa" do
    taxon_id = UUID.random
    taxon = SaveTaxon.create!(params, id: taxon_id)
    custom_taxon = SaveCustomTaxon.create!(taxon_ptr_id: taxon_id, user_id: current_user.id)
    head HTTP::Status::CREATED
  end
end
