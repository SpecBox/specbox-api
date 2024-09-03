class SaveCustomTaxon < CustomTaxon::SaveOperation
  permit_columns(
    taxon_ptr_id,
    user_id
  )
end
