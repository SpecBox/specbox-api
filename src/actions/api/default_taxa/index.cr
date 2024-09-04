# デフォルト分類情報のリスト取得API
class Api::DefaultTaxa::Index < ApiAction
  get "/api/default-taxa" do
    query = TaxonQuery.new.only_default_taxon
    string_chain_filters(query,
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
    number_chain_filters(query,
      name_publishedin_year,
      actual_dist_year
    )
    bool_chain_filters(query,
      change_genus_brackets,
      unknown_author_brackets,
      unknown_name_publishedin_year_brackets
    )
    datetime_chain_filters(query, created_at)
    ordering_single_column_query(query, :ordering,
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
    pages, query = paginate(query, per_page: paginater_per_page)
    json TaxonSerializer.for_collection_with_paginate(query, pages)
  end
end
