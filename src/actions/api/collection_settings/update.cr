# コレクション設定の更新API
class Api::CollectionSettings::Update < ApiAction
  put "/api/collection-settings/own-collection-settings/:collection_setting_id" do
    collection_setting = CollectionSettingQuery.new.find(collection_setting_id)
    if collection_setting.user_id == current_user.id
      SaveCollectionSetting.update!(collection_setting, params)
      head 204
    else
      head 403
    end
  end
end
