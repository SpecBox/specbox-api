class Api::CollectionSettings::BulkUpdate < ApiAction
  # Bulk update
  patch "/api/collection-settings" do
    if validate_params_for_bulk(params)
      serialized_params = SerializedCollectionSettingJsonForBulkUpdate.from_json(params.body)
      ids = serialized_params.ids
      check_invalid_user_id_query = CollectionSettingQuery.new.id.in(ids).user_id.not.eq(current_user.id).select_count
      if check_invalid_user_id_query > 0
        head 403
      else
        update_targets = CollectionSettingQuery.new.id.in(ids).user_id(current_user.id)
        update_data = serialized_params.data
        bulk_update(update_targets, update_data, collection_name, institution_code, latest_collection_code, note)
        head 204
      end
    else
      head 400
    end
  end
end
