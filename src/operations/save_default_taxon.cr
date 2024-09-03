class SaveDefaultTaxon < DefaultTaxon::SaveOperation
  permit_columns(
    taxon_ptr_id,
  )
end
