# 採集行のID指定取得API
class Api::Tours::Show < ApiAction
  get "/api/tours/:record_id" do
    record = TourQuery.new.find(record_id)
    if record.user_id == current_user.id
      json TourSerializer.nested_key_data(record)
    else
      head 403
    end
  end
end
