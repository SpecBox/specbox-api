class Specimens::PercentageCollectPoint < ApiAction
  get "/api/specimens/percentage_collect_point" do
    target_collect_point = params.get("target_place")
    target_collection = params.get?("target_collection")
    is_all = params.get("is_all")
    results = SpecimenPercentageCollectPointQuery.all(current_user.id, target_collection, target_collect_point, is_all)
    json SpecimenPercentageCollectPointSerializer.top_and_other(results, 10)
  end
end
