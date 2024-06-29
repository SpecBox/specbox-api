# 採集地点の削除API
class Api::CollectPoints::Delete < ApiAction
  delete "/api/collect-points/:record_id" do
    record = CollectPointQuery.new.find(record_id)
    if record.user_id == current_user.id
      DeleteCollectPoint.delete!(record)
      head 204
    else
      head 403
    end
  end
end
