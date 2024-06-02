class Api::CollectionSettings::Index < ApiAction
  get "/api/collection-settings/own-collection-settings" do
    collection_settings = CollectionSettingQuery.new.user_id(current_user.id)
    json CollectionSettingSerializer.for_collection(collection_settings)
  end
end
