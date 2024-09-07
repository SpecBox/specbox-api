class Api::Specimens::BulkUpdate < ApiAction
  patch "/api/specimens" do
    if validate_params_for_bulk(params)
      serialized_params = SerializedSpecimenJsonForBulkUpdate.from_json(params.body)
      ids = serialized_params.ids
      check_invalid_user_id_query = SpecimenQuery.new.user_id(current_user.id).select_count
      if check_invalid_user_id_query != ids.size
        head 404
      else
        update_targets = SpecimenQuery.new.id.in(ids)
        update_data = serialized_params.data
        bulk_update(
          update_targets, update_data,
          custom_taxon_info_id,
          default_taxon_info_id,
          collect_point_info_id,
          collection_settings_info_id,
          tour_id,
          collection_code,
          identified_by,
          date_identified,
          collecter,
          year,
          month,
          day,
          sex,
          preparation_type,
          disposition,
          sampling_protocol,
          sampling_effort,
          lifestage,
          establishment_means,
          rights,
          allow_kojin_shuzo,
          published_kojin_shuzo,
          note,
          image1,
          image2,
          image3,
          image4,
          image5
        )
        head 204
      end
    else
      head 400
    end
  end
end
