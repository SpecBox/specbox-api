class SaveAuthUser < AuthUser::SaveOperation
  permit_columns(username, date_joined)
end
