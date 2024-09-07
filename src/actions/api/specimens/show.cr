class Api::Specimens::Show < ApiAction
  get "/api/specimens/:record_id" do
    record = SpecimenQuery.new.all_preload.user_id(current_user.id).find(record_id)
    json SpecimenSerializer.nested_key_data(record)
  end
end
