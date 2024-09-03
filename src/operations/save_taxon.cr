require "./mixins/save_base64_image"
require "./mixins/regex"

class SaveTaxon < Taxon::SaveOperation
  permit_columns(
    id,
    kingdom,
    phylum,
    class_name,
    order,
    suborder,
    family,
    subfamily,
    tribe,
    subtribe,
    genus,
    subgenus,
    species,
    subspecies,
    scientific_name_author,
    name_publishedin_year,
    change_genus_brackets,
    unknown_author_brackets,
    unknown_name_publishedin_year_brackets,
    actual_dist_year,
    japanese_name,
    distribution,
    note,
    image1,
    image2,
    image3,
    image4,
    image5
  )

  before_save do
    validate_size_of kingdom, max: 30
    validate_format_of kingdom, ValidationRegex.sentence_case_word

    validate_size_of phylum, max: 30
    validate_format_of phylum, ValidationRegex.sentence_case_word

    validate_size_of class_name, max: 30
    validate_format_of class_name, ValidationRegex.sentence_case_word

    validate_size_of order, max: 30
    validate_format_of order, ValidationRegex.sentence_case_word

    validate_size_of suborder, max: 30
    validate_format_of suborder, ValidationRegex.sentence_case_word

    validate_size_of family, max: 30
    validate_format_of family, ValidationRegex.sentence_case_word

    validate_size_of tribe, max: 30
    validate_format_of tribe, ValidationRegex.sentence_case_word

    validate_size_of subtribe, max: 30
    validate_format_of subtribe, ValidationRegex.sentence_case_word

    validate_size_of genus, max: 30
    validate_format_of genus, ValidationRegex.sentence_case_word

    validate_size_of subgenus, max: 30
    validate_format_of subgenus, ValidationRegex.sentence_case_word

    validate_size_of species, max: 30
    validate_format_of species, ValidationRegex.lower_case_word

    validate_size_of subspecies, max: 30
    validate_format_of subspecies, ValidationRegex.lower_case_word

    validate_size_of scientific_name_author, max: 50

    validate_size_of japanese_name, max: 30

    validate_size_of note, max: 500

    Base64Image.save_base64_images(image1, image2, image3, image4, image5)
  end
end
