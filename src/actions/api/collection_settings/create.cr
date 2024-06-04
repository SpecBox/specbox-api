# コレクション設定の作成API
class Api::CollectionSettings::Create < ApiAction
  post "/api/collection-settings/own-collection-settings" do
    collection_setting = SaveCollectionSetting.create!(params, id: UUID.random, user_id: current_user.id)
    head HTTP::Status::CREATED
  end
end
