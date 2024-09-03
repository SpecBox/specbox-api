# デフォルト分類情報の作成API
class Api::DefaultTaxa::Create < ApiAction
  post "/api/default-taxa" do
    taxon_id = UUID.random
    taxon = SaveTaxon.create!(params, id: taxon_id)
    default_taxon = SaveDefaultTaxon.create!(taxon_ptr_id: taxon_id)
    head HTTP::Status::CREATED
  end
end
