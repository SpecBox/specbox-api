class Api::CustomTaxa::BulkUpdate < ApiAction
  patch "/api/custom-taxa" do
    if validate_params_for_bulk(params)
      serialized_params = SerializedTaxonJsonForBulkUpdate.from_json(params.body)
      ids = serialized_params.ids
      check_invalid_user_id_query = CustomTaxonQuery.new.taxon_ptr_id.in(ids).user_id.eq(current_user.id).select_count
      if check_invalid_user_id_query != ids.size
        head 404
      else
        update_targets = TaxonQuery.new.id.in(ids)
        update_data = serialized_params.data
        bulk_update(
          update_targets, update_data,
          kingdom,
          phylum,
          class_name,
          order,
          suborder,
          family,
          subfamily,
          tribe,
          subtribe,
          genus,
          subgenus,
          species,
          subspecies,
          scientific_name_author,
          name_publishedin_year,
          change_genus_brackets,
          unknown_author_brackets,
          unknown_name_publishedin_year_brackets,
          actual_dist_year,
          japanese_name,
          distribution,
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
