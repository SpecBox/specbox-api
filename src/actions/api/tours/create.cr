# 採集行の作成API
class Api::Tours::Create < ApiAction
  post "/api/tours" do
    id = UUID.random
    record = SaveTour.create!(params, id: id, user_id: current_user.id)
    if record
      many_to_many("tour", "collect_points", id, tour_id, collectpoint_id, UUID, CollectPointsTourQuery, SaveCollectPointsTour)
    end
    head HTTP::Status::CREATED
  end
end
