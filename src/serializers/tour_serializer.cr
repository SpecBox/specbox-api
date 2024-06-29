require "./mixins/switch_avram_nothing"
require "./mixins/simple_date_converter"

# 採集行のシリアライザ
class TourSerializer < BaseSerializer
  def initialize(@tour : Tour)
  end

  def render
    {
      id:             @tour.id,
      created_at:     @tour.created_at,
      title:          @tour.title,
      start_date:     SimpleDateConverter.simple_date_converter.format(@tour.start_date),
      end_date:       SimpleDateConverter.simple_date_converter.format(@tour.end_date),
      note:           @tour.note,
      image1:         @tour.image1,
      image2:         @tour.image2,
      image3:         @tour.image3,
      image4:         @tour.image4,
      image5:         @tour.image5,
      collect_points: CollectPointsTourQuery.new.tour_id(@tour.id).map(&.collectpoint_id),
    }
  end
end

# JSONから採集行へのシリアライズ用クラス
class SerializedTourJsonForBulkUpdate
  include JSON::Serializable
  include JSON::Serializable::Strict

  property ids : Array(UUID)
  property data : SerializedTourForBulkUpdate
end

@[JSON::Serializable::Options(emit_nulls: true)]
class SerializedTourForBulkUpdate
  include JSON::Serializable

  property title : String?
  @[JSON::Field(converter: SimpleDateConverter.simple_date_converter)]
  property start_date : Time?
  @[JSON::Field(converter: SimpleDateConverter.simple_date_converter)]
  property end_date : Time?
  property note : String?
  property image1 : String?
  property image2 : String?
  property image3 : String?
  property image4 : String?
  property image5 : String?

  switch_avram_nothing_for_serialize_class(
    title,
    start_date,
    end_date,
    note,
    image1,
    image2,
    image3,
    image4,
    image5
  )
end
