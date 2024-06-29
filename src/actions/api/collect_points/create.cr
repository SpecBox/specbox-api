# 採集地点の作成API
class Api::CollectPoints::Create < ApiAction
  post "/api/collect-points" do
    id = UUID.random
    collect_point = SaveCollectPoint.create!(params, id: id, user_id: current_user.id)
    if collect_point
      many_to_many("collect_point", "tours", id, collectpoint_id, tour_id, UUID, CollectPointsTourQuery, SaveCollectPointsTour)
    end
    head HTTP::Status::CREATED
  end
end
