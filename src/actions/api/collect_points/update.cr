# 採集地点の更新API
class Api::CollectPoints::Update < ApiAction
  put "/api/collect-points/:record_id" do
    record = CollectPointQuery.new.find(record_id)
    if record.user_id == current_user.id
      collect_point = SaveCollectPoint.update!(record, params)
      if collect_point
        many_to_many("collect_point", "tours", UUID.new(record_id), collectpoint_id, tour_id, UUID, CollectPointsTourQuery, SaveCollectPointsTour)
      end
      head 204
    else
      head 403
    end
  end
end
