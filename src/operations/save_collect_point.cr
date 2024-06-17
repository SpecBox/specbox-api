require "./mixins/save_base64_image"

class SaveCollectPoint < CollectPoint::SaveOperation
  permit_columns(
    id,
    user_id,
    contient,
    island_group,
    island,
    country,
    state_provice,
    county,
    municipality,
    verbatim_locality,
    japanese_place_name,
    japanese_place_name_detail,
    coordinate_precision,
    location,
    minimum_elevation,
    maximum_elevation,
    minimum_depth,
    maximum_depth,
    note,
    image1,
    image2,
    image3,
    image4,
    image5,
  )

  before_save do
    Base64Image.save_base64_images(image1, image2, image3, image4, image5)
  end
end
