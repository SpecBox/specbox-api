# 採集行のリスト取得API
class Api::Tours::Index < ApiAction
  get "/api/tours" do
    query = TourQuery.new.user_id(current_user.id)
    string_chain_filters(query,
      title,
      note
    )
    datetime_chain_filters(query, created_at, start_date, end_date)
    ordering_single_column_query(query, :ordering,
      created_at,
      title,
      start_date,
      end_date,
      note,
      created_at
    )
    pages, query = paginate(query, per_page: paginater_per_page)
    json TourSerializer.for_collection_with_paginate(query, pages)
  end
end
