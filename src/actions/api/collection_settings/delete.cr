class Api::CollectionSettings::Delete < ApiAction
  delete "/api/collection-settings/own-collection-settings/:collection_setting_id" do
    collection_setting = CollectionSettingQuery.new.find(collection_setting_id)
    if collection_setting.user_id == current_user.id
      DeleteCollectionSetting.delete!(collection_setting)
      head 204
    else
      head 403
    end
  end
end
