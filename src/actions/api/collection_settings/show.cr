# コレクション設定のID指定取得API
class Api::CollectionSettings::Show < ApiAction
  get "/api/collection-settings/:collection_setting_id" do
    collection_setting = CollectionSettingQuery.new.find(collection_setting_id)
    if collection_setting.user_id == current_user.id
      json CollectionSettingSerializer.nested_key_data(collection_setting)
    else
      head 403
    end
  end
end
