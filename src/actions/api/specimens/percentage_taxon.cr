class Specimens::PercentageTaxon < ApiAction
  get "/api/specimens/percentage_taxon" do
    target_taxon = params.get("target_taxon")
    target_collection = params.get?("target_collection")
    is_all = params.get("is_all")
    results = SpecimenPercentageTaxonQuery.all(current_user.id, target_collection, target_taxon, is_all)
    json SpecimenPercentageTaxonSerializer.top_and_other(results, 10)
  end
end
