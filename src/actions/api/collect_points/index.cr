# 採集地点のリスト取得API
class Api::CollectPoints::Index < ApiAction
  get "/api/collect-points" do
    query = CollectPointQuery.new.user_id(current_user.id)
    string_chain_filters(query,
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
    number_chain_filters(query,
      coordinate_precision,
      minimum_elevation,
      maximum_elevation,
      minimum_depth,
      maximum_depth
    )
    datetime_chain_filters(query, created_at)
    geo_point_chain_filters(query, location)
    geo_point_distance_filters(query, location)
    ordering_single_column_query(query, :ordering,
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
    pages, query = paginate(query, per_page: paginater_per_page)
    json CollectPointSerializer.for_collection_with_paginate(query, pages)
  end
end
