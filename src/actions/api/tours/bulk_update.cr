# 採集行のバルク更新API
class Api::Tours::BulkUpdate < ApiAction
  patch "/api/tours" do
    if validate_params_for_bulk(params)
      serialized_params = SerializedTourJsonForBulkUpdate.from_json(params.body)
      ids = serialized_params.ids
      check_invalid_user_id_query = TourQuery.new.id.in(ids).user_id.not.eq(current_user.id).select_count
      if check_invalid_user_id_query > 0
        head 403
      else
        update_targets = TourQuery.new.id.in(ids).user_id(current_user.id)
        update_data = serialized_params.data
        bulk_update(
          update_targets, update_data,
          title,
          start_date,
          end_date,
          note,
          image1,
          image2,
          image3,
          image4,
          image5
        )
      end
      ids.each do |id|
        many_to_many_for_bulk("collect_points", id, tour_id, collectpoint_id, UUID, CollectPointsTourQuery, SaveCollectPointsTour)
      end
      head 204
    else
      head 400
    end
  end
end
