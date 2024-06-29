# 採集行の削除API
class Api::Tours::Delete < ApiAction
  delete "/api/tours/:record_id" do
    record = TourQuery.new.find(record_id)
    if record.user_id == current_user.id
      DeleteTour.delete!(record)
      head 204
    else
      head 403
    end
  end
end
