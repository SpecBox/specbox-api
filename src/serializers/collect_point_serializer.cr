require "./mixins/switch_avram_nothing.cr"

# 採集地点のシリアライザ
class CollectPointSerializer < BaseSerializer
  def initialize(@collect_point : CollectPoint)
  end

  def render
    {
      id:                         @collect_point.id,
      created_at:                 @collect_point.created_at,
      contient:                   @collect_point.contient,
      island_group:               @collect_point.island_group,
      island:                     @collect_point.island,
      country:                    @collect_point.country,
      state_provice:              @collect_point.state_provice,
      county:                     @collect_point.county,
      municipality:               @collect_point.municipality,
      verbatim_locality:          @collect_point.verbatim_locality,
      japanese_place_name:        @collect_point.japanese_place_name,
      japanese_place_name_detail: @collect_point.japanese_place_name_detail,
      coordinate_precision:       @collect_point.coordinate_precision,
      location:                   @collect_point.location,
      minimum_elevation:          @collect_point.minimum_elevation,
      maximum_elevation:          @collect_point.maximum_elevation,
      minimum_depth:              @collect_point.minimum_depth,
      maximum_depth:              @collect_point.maximum_depth,
      note:                       @collect_point.note,
      image1:                     @collect_point.image1,
      image2:                     @collect_point.image2,
      image3:                     @collect_point.image3,
      image4:                     @collect_point.image4,
      image5:                     @collect_point.image5,
      tours:                      CollectPointsTourQuery.new.collectpoint_id(@collect_point.id).map(&.tour_id),
    }
  end
end

# JSONから採集地点へのシリアライズ用クラス
class SerializedCollectPointJsonForBulkUpdate
  include JSON::Serializable
  include JSON::Serializable::Strict

  property ids : Array(UUID)
  property data : SerializedCollectPointForBulkUpdate
end

@[JSON::Serializable::Options(emit_nulls: true)]
class SerializedCollectPointForBulkUpdate
  include JSON::Serializable

  property contient : String?
  property island_group : String?
  property island : String?
  property country : String?
  property state_provice : String?
  property county : String?
  property municipality : String?
  property verbatim_locality : String?
  property japanese_place_name : String?
  property japanese_place_name_detail : String?
  property coordinate_precision : Float64?
  property location : PostGIS::Point2D?
  property minimum_elevation : Float64?
  property maximum_elevation : Float64?
  property minimum_depth : Float64?
  property maximum_depth : Float64?
  property note : String?
  property image1 : String?
  property image2 : String?
  property image3 : String?
  property image4 : String?
  property image5 : String?

  switch_avram_nothing_for_serialize_class(
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
end
