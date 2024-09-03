require "./mixins/switch_avram_nothing.cr"

# 分類情報のシリアライザ
class TaxonSerializer < BaseSerializer
  def initialize(@taxon : Taxon)
  end

  def render
    {
      id:                                     @taxon.id,
      created_at:                             @taxon.created_at,
      kingdom:                                @taxon.kingdom,
      phylum:                                 @taxon.phylum,
      class_name:                             @taxon.class_name,
      order:                                  @taxon.order,
      suborder:                               @taxon.suborder,
      family:                                 @taxon.family,
      subfamily:                              @taxon.subfamily,
      tribe:                                  @taxon.tribe,
      subtribe:                               @taxon.subtribe,
      genus:                                  @taxon.genus,
      subgenus:                               @taxon.subgenus,
      species:                                @taxon.species,
      subspecies:                             @taxon.subspecies,
      scientific_name_author:                 @taxon.scientific_name_author,
      name_publishedin_year:                  @taxon.name_publishedin_year,
      change_genus_brackets:                  @taxon.change_genus_brackets,
      unknown_author_brackets:                @taxon.unknown_author_brackets,
      unknown_name_publishedin_year_brackets: @taxon.unknown_name_publishedin_year_brackets,
      actual_dist_year:                       @taxon.actual_dist_year,
      japanese_name:                          @taxon.japanese_name,
      distribution:                           @taxon.distribution,
      note:                                   @taxon.note,
      image1:                                 @taxon.image1,
      image2:                                 @taxon.image2,
      image3:                                 @taxon.image3,
      image4:                                 @taxon.image4,
      image5:                                 @taxon.image5,
    }
  end
end

# JSONから分類情報へのシリアライズ用クラス
class SerializedTaxonJsonForBulkUpdate
  include JSON::Serializable
  include JSON::Serializable::Strict

  property ids : Array(UUID)
  property data : SerializedTaxonForBulkUpdate
end

@[JSON::Serializable::Options(emit_nulls: true)]
class SerializedTaxonForBulkUpdate
  include JSON::Serializable

  property kingdom : String?
  property phylum : String?
  property class_name : String?
  property order : String?
  property suborder : String?
  property family : String?
  property subfamily : String?
  property tribe : String?
  property subtribe : String?
  property genus : String?
  property subgenus : String?
  property species : String?
  property subspecies : String?
  property scientific_name_author : String?
  property name_publishedin_year : Int32?
  property change_genus_brackets : Bool?
  property unknown_author_brackets : Bool?
  property unknown_name_publishedin_year_brackets : Bool?
  property actual_dist_year : Int32?
  property japanese_name : String?
  property distribution : String?
  property note : String?
  property image1 : String?
  property image2 : String?
  property image3 : String?
  property image4 : String?
  property image5 : String?

  switch_avram_nothing_for_serialize_class(
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
end
