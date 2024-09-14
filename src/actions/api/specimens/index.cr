# 標本のリスト取得API
class Api::Specimens::Index < ApiAction
  get "/api/specimens" do
    query = SpecimenQuery.new.all_preload.user_id(current_user.id)
    all_specimens = query.clone
    param_keys = params.to_h.keys

    string_chain_filters(query,
      identified_by,
      collecter,
      sex,
      preparation_type,
      disposition,
      sampling_protocol,
      sampling_effort,
      lifestage,
      establishment_means,
      rights,
      note
    )
    number_chain_filters(query,
      collection_code,
      year,
      month,
      day
    )
    bool_chain_filters(query,
      allow_kojin_shuzo,
      published_kojin_shuzo
    )
    datetime_chain_filters(query, date_last_modified, date_identified)

    taxon_query = TaxonQuery.new
    string_chain_filters_for_relation(taxon_query, taxon,
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
      japanese_name,
      distribution,
      note
    )
    number_chain_filters_for_relation(taxon_query, taxon,
      name_publishedin_year,
      actual_dist_year
    )
    bool_chain_filters_for_relation(taxon_query, taxon,
      change_genus_brackets,
      unknown_author_brackets,
      unknown_name_publishedin_year_brackets
    )
    datetime_chain_filters_for_relation(taxon_query, taxon, created_at)
    ordering_single_column_query_for_relation(taxon_query, taxon, :ordering,
      created_at,
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
      japanese_name,
      distribution,
      note,
      name_publishedin_year,
      actual_dist_year,
      created_at
    )
    query = query.with_all_taxa.where_custom_taxon_info(taxon_query, auto_inner_join: false).where_default_taxon_info(taxon_query, auto_inner_join: false)

    collect_point_query = CollectPointQuery.new
    string_chain_filters_for_relation(collect_point_query, collect_point,
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
      note
    )
    number_chain_filters_for_relation(collect_point_query, collect_point,
      coordinate_precision,
      minimum_elevation,
      maximum_elevation,
      minimum_depth,
      maximum_depth
    )
    datetime_chain_filters_for_relation(collect_point_query, collect_point, created_at)
    geo_point_chain_filters_for_relation(collect_point_query, collect_point, location)
    geo_point_distance_filters_for_relation(collect_point_query, collect_point, location)
    ordering_single_column_query_for_relation(collect_point_query, collect_point, :ordering,
      created_at,
      contient,
      island_group,
      island,
      country,
      state_provice,
      county,
      municipality,
      verbatim_locality,
      coordinate_precision,
      minimum_elevation,
      maximum_elevation,
      minimum_depth,
      maximum_depth,
      japanese_place_name,
      japanese_place_name_detail,
      note,
      created_at
    )
    query = query.left_join_collect_point_info.where_collect_point_info(collect_point_query, auto_inner_join: false)

    collection_setting_query = CollectionSettingQuery.new
    string_chain_filters_for_relation(collection_setting_query, collection_settings,
      collection_name, institution_code, note)
    number_chain_filters_for_relation(collection_setting_query, collection_settings,
      latest_collection_code)
    datetime_chain_filters_for_relation(collection_setting_query, collection_settings,
      created_at)
    ordering_single_column_query_for_relation(collection_setting_query, collection_settings, :ordering, created_at,
      collection_name,
      institution_code,
      latest_collection_code,
      created_at)
    query = query.left_join_collection_settings_info.where_collection_settings_info(collection_setting_query, auto_inner_join: false)

    tour_query = TourQuery.new
    string_chain_filters_for_relation(tour_query, tour,
      title,
      note
    )
    datetime_chain_filters_for_relation(tour_query, tour,
      created_at,
      start_date,
      end_date)
    ordering_single_column_query_for_relation(tour_query, tour, :ordering, created_at,
      title,
      start_date,
      end_date,
      note,
      created_at
    )
    query = query.left_join_tour.where_tour(tour_query, auto_inner_join: false)

    query_for_count_taxon = query.clone
    target_taxon = if params.get?("target_taxon")
                     params.get("target_taxon")
                   else
                     "subspecies"
                   end

    ordering_single_column_query(query, :ordering,
      date_last_modified,
      identified_by,
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
      note,
      collection_code,
      allow_kojin_shuzo,
      published_kojin_shuzo,
      date_last_modified,
      date_identified
    )
    pages, query = paginate(query, per_page: paginater_per_page)

    json SpecimenSerializer.for_collection_with_paginate_and_taxon_count(query, pages, query_for_count_taxon, target_taxon, all_specimens)
  end
end
