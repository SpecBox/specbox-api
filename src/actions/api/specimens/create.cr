class Api::Specimens::Create < ApiAction
  post "/api/specimens" do
    SaveSpecimen.create!(params, id: UUID.random, user_id: current_user.id, date_last_modified: Time.local)
    head HTTP::Status::CREATED
  end
end
