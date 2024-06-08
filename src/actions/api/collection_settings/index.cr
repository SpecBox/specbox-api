# コレクション設定のリスト取得API
class Api::CollectionSettings::Index < ApiAction
  get "/api/collection-settings/own-collection-settings" do
    query = CollectionSettingQuery.new.user_id(current_user.id)
    string_chain_filters(query, collection_name, institution_code, note)
    number_chain_filters(query, latest_collection_code)
    datetime_chain_filters(query, created_at)
    ordering_single_column_query(query, :ordering, created_at, collection_name, institution_code, latest_collection_code, created_at)
    pages, query = paginate(query, per_page: paginater_per_page)
    json CollectionSettingSerializer.for_collection(query, pages)
  end
end
