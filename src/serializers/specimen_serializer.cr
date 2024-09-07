# 採集地点のシリアライザ
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
