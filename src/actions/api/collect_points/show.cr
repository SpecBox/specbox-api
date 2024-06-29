# 採集地点のID指定取得API
class Api::CollectPoints::Show < ApiAction
  get "/api/collect-points/:collect_point_id" do
    collect_point = CollectPointQuery.new.find(collect_point_id)
    if collect_point.user_id == current_user.id
      json CollectPointSerializer.nested_key_data(collect_point)
    else
      head 403
    end
  end
end
