class SaveCollectPointsTour < CollectPointsTour::SaveOperation
  permit_columns(
    collectpoint_id,
    tour_id
  )
end
