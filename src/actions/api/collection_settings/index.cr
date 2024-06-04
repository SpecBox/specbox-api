# コレクション設定のリスト取得API
class Api::CollectionSettings::Index < ApiAction
  get "/api/collection-settings/own-collection-settings" do
    query = CollectionSettingQuery.new.user_id(current_user.id)
    if params.get?(:collection_name)
      query = query.collection_name.ilike("%#{params.get(:collection_name)}%")
    end
    if params.get?(:institution_code)
      query = query.institution_code.ilike("%#{params.get(:institution_code)}%")
    end
    if params.get?(:latest_collection_code_min)
      query = query.latest_collection_code.gte(params.get(:latest_collection_code_min))
    end
    if params.get?(:latest_collection_code_max)
      query = query.latest_collection_code.lte(params.get(:latest_collection_code_max))
    end
    if params.get?(:note)
      query = query.note.ilike("%#{params.get(:note)}%")
    end
    if params.get?(:created_at)
      query = query.created_at.as_date.eq(params.get(:created_at))
    end
    if params.get?(:sort)
      sort_column = params.get(:sort)
      if sort_column == "collection_name"
        query = switch_order(query.collection_name, params)
      elsif sort_column == "institution_code"
        query = switch_order(query.institution_code, params)
      elsif sort_column == "latest_collection_code"
        query = switch_order(query.latest_collection_code, params)
      else
        query = switch_order(query.created_at, params)
      end
    else
      query = switch_order(query.created_at, params)
    end
    json CollectionSettingSerializer.for_collection(query)
  end
end
