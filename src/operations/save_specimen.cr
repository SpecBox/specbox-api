require "./mixins/save_base64_image"
require "./mixins/regex"

class SaveSpecimen < Specimen::SaveOperation
  SEX_INITIALS = {"M", "F", "H", "I", "U", "T"}
  permit_columns(
    id,
    user_id,
    custom_taxon_info_id,
    default_taxon_info_id,
    collect_point_info_id,
    collection_settings_info_id,
    tour_id,
    collection_code,
    identified_by,
    date_identified,
    collecter,
    year,
    month,
    day,
    sex,
    preparation_type,
    disposition,
    sampling_protocol,
    sampling_effort,
    lifestage,
    establishment_means,
    rights,
    note,
    allow_kojin_shuzo,
    published_kojin_shuzo,
    image1,
    image2,
    image3,
    image4,
    image5
  )

  before_save do
    validate_numeric collection_code, at_least: 0, no_more_than: 999999999999999999i64
    validate_size_of identified_by, min: 0, max: 18
    validate_size_of collecter, min: 0, max: 18
    validate_numeric year, at_least: 0, no_more_than: 9999
    validate_numeric month, at_least: 0, no_more_than: 12
    validate_numeric day, at_least: 0, no_more_than: 31
    validate_size_of sex, is: 1 
    validate_inclusion_of sex, in: SEX_INITIALS
    validate_size_of preparation_type, min: 0, max: 20
    validate_size_of disposition, min: 0, max: 30
    validate_size_of sampling_protocol, min: 0, max: 20
    validate_size_of sampling_effort, min: 0, max: 100
    validate_size_of lifestage, min: 0, max: 20
    validate_size_of establishment_means, min: 0, max: 20
    validate_size_of rights, min: 0, max: 10
    validate_size_of note, min: 0, max: 200
    Base64Image.save_base64_images(image1, image2, image3, image4, image5)
  end
end
