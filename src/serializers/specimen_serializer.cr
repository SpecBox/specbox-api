require "./mixins/switch_avram_nothing"
require "./mixins/simple_date_converter"

# 標本のシリアライザ
class SpecimenSerializer < BaseSerializer
  def initialize(@specimen : Specimen)
  end

  def render
    {
      id:                    @specimen.id,
      date_last_modified:    @specimen.date_last_modified,
      user_id:               @specimen.user_id,
      custom_taxon:          @specimen.custom_taxon_info ? TaxonSerializer.new(@specimen.custom_taxon_info.not_nil!) : nil,
      default_taxon:         @specimen.default_taxon_info ? TaxonSerializer.new(@specimen.default_taxon_info.not_nil!) : nil,
      collect_point:         @specimen.collect_point_info ? CollectPointSerializer.new(@specimen.collect_point_info.not_nil!) : nil,
      collection_settings:   @specimen.collection_settings_info ? CollectionSettingSerializer.new(@specimen.collection_settings_info.not_nil!) : nil,
      tour:                  @specimen.tour ? TourSerializer.new(@specimen.tour.not_nil!) : nil,
      collection_code:       @specimen.collection_code,
      identified_by:         @specimen.identified_by,
      date_identified:       @specimen.date_identified,
      collecter:             @specimen.collecter,
      year:                  @specimen.year,
      month:                 @specimen.month,
      day:                   @specimen.day,
      sex:                   @specimen.sex,
      preparation_type:      @specimen.preparation_type,
      disposition:           @specimen.disposition,
      sampling_protocol:     @specimen.sampling_protocol,
      sampling_effort:       @specimen.sampling_effort,
      lifestage:             @specimen.lifestage,
      establishment_means:   @specimen.establishment_means,
      rights:                @specimen.rights,
      allow_kojin_shuzo:     @specimen.allow_kojin_shuzo,
      published_kojin_shuzo: @specimen.published_kojin_shuzo,
      note:                  @specimen.note,
      image1:                @specimen.image1,
      image2:                @specimen.image2,
      image3:                @specimen.image3,
      image4:                @specimen.image4,
      image5:                @specimen.image5,
    }
  end
end

# JSONから標本へのシリアライズ用クラス
class SerializedSpecimenJsonForBulkUpdate
  include JSON::Serializable
  include JSON::Serializable::Strict

  property ids : Array(UUID)
  property data : SerializedSpecimenForBulkUpdate
end

@[JSON::Serializable::Options(emit_nulls: true)]
class SerializedSpecimenForBulkUpdate
  include JSON::Serializable

  property custom_taxon_info_id : UUID?
  property default_taxon_info_id : UUID?
  property collect_point_info_id : UUID?
  property collection_settings_info_id : UUID?
  property tour_id : UUID?
  property collection_code : Int32?
  property identified_by : String?
  @[JSON::Field(converter: SimpleDateConverter.simple_date_converter)]
  property date_identified : Time?
  property collecter : String?
  property year : Int32?
  property month : Int32?
  property day : Int32?
  property sex : String?
  property preparation_type : String?
  property disposition : String?
  property sampling_protocol : String?
  property sampling_effort : String?
  property lifestage : String?
  property establishment_means : String?
  property rights : String?
  property allow_kojin_shuzo : Bool?
  property published_kojin_shuzo : Bool?
  property note : String?
  property image1 : String?
  property image2 : String?
  property image3 : String?
  property image4 : String?
  property image5 : String?

  switch_avram_nothing_for_serialize_class(
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
    allow_kojin_shuzo,
    published_kojin_shuzo,
    note,
    image1,
    image2,
    image3,
    image4,
    image5
  )
end
