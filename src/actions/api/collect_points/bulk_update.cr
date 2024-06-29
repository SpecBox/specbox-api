class Api::CollectPoints::BulkUpdate < ApiAction
  patch "/api/collect-points" do
    if validate_params_for_bulk(params)
      serialized_params = SerializedCollectPointJsonForBulkUpdate.from_json(params.body)
      ids = serialized_params.ids
      check_invalid_user_id_query = CollectPointQuery.new.id.in(ids).user_id.not.eq(current_user.id).select_count
      if check_invalid_user_id_query > 0
        head 403
      else
        update_targets = CollectPointQuery.new.id.in(ids).user_id(current_user.id)
        update_data = serialized_params.data
        bulk_update(
          update_targets, update_data,
          contient,
          island_group,
          island,
          country,
          state_provice,
          county,
          municipality,
          verbatim_locality,
          japanese_place_name,
          japanese_place_name_detail,
          coordinate_precision,
          location,
          minimum_elevation,
          maximum_elevation,
          minimum_depth,
          maximum_depth,
          note,
          image1,
          image2,
          image3,
          image4,
          image5
        )
      end
      ids.each do |id|
        many_to_many_for_bulk("tours", id, collectpoint_id, tour_id, UUID, CollectPointsTourQuery, SaveCollectPointsTour)
      end
      head 204
    else
      head 400
    end
  end
end
