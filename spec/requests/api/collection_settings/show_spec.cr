require "../../../spec_helper"

describe Api::CollectionSettings::Show do
  it "returns 200 response" do
    collection_setting = CollectionSettingFactory.create
    response = ApiClient.auth(current_user).exec(Api::CollectionSettings::Show.with(collection_setting.id))
    response.should send_json(200)
  end
end
