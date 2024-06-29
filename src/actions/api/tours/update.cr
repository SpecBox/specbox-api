# 採集行の更新API
class Api::Tours::Update < ApiAction
  put "/api/tours/:record_id" do
    record = TourQuery.new.find(record_id)
    if record.user_id == current_user.id
      tour = SaveTour.update!(record, params)
      if tour
        many_to_many("tour", "collect_points", UUID.new(record_id), tour_id, collectpoint_id, UUID, CollectPointsTourQuery, SaveCollectPointsTour)
      end
      head 204
    else
      head 403
    end
  end
end
