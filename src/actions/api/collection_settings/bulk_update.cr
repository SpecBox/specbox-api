class Api::CollectionSettings::BulkUpdate < ApiAction
  # Bulk update
  put "/api/collection-settings" do
    Log.debug { params.from_json }
    params_hash = params.from_json
    if !(params_hash["ids"]? && params_hash["data"]?)
      head 400
    else
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
    end
  end
end
