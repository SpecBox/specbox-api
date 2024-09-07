class Api::Specimens::Update < ApiAction
  put "/api/specimens/:id" do
    record = SpecimenQuery.new.user_id(current_user.id).find(id)
    SaveSpecimen.update!(record, params)
    head 204
  end
end
