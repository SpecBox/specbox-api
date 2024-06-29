require "./mixins/save_base64_image"
require "./mixins/countries"
require "./mixins/regex"

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
    image5
  )

  before_save do
    validate_size_of contient, max: 20
    validate_format_of contient, with: ValidationRegex.ascii

    validate_size_of island_group, max: 30
    validate_format_of island_group, with: ValidationRegex.ascii_and_accent

    validate_size_of island, max: 24
    validate_format_of island, with: ValidationRegex.ascii_and_accent

    validate_size_of county, max: 2
    validate_inclusion_of country, in: Countries.all_alpha_2

    validate_size_of state_provice, max: 30
    validate_format_of state_provice, with: ValidationRegex.ascii_and_accent

    validate_size_of county, max: 30
    validate_format_of county, with: ValidationRegex.ascii_and_accent

    validate_size_of municipality, max: 50
    validate_format_of municipality, with: ValidationRegex.ascii_and_accent

    validate_size_of verbatim_locality, max: 200

    validate_size_of japanese_place_name, max: 14

    validate_size_of japanese_place_name_detail, max: 50

    validate_size_of note, max: 200

    Base64Image.save_base64_images(image1, image2, image3, image4, image5)
  end
end
