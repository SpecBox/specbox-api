class Api::Specimens::Delete < ApiAction
  delete "/api/specimens/:record_id" do
    record = SpecimenQuery.new.user_id(current_user.id).find(record_id)
    DeleteSpecimen.delete!(record)
    head 204
  end
end
