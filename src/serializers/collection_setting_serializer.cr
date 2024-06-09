require "./mixins/switch_avram_nothing"

# コレクション設定のシリアライザ
class CollectionSettingSerializer < BaseSerializer
  def initialize(@collection_setting : CollectionSetting)
  end

  def render
    {
      id:                     @collection_setting.id,
      created_at:             @collection_setting.created_at,
      collection_name:        @collection_setting.collection_name,
      institution_code:       @collection_setting.institution_code,
      latest_collection_code: @collection_setting.latest_collection_code,
      note:                   @collection_setting.note,
    }
  end
end

# JSONからコレクション設定へのシリアライズ用クラス
class SerializedCollectionSettingJsonForBulkUpdate
  include JSON::Serializable
  include JSON::Serializable::Strict
  property ids : Array(UUID)
  property data : SerializedCollectionSettingForBulkUpdate
end

@[JSON::Serializable::Options(emit_nulls: true)]
class SerializedCollectionSettingForBulkUpdate
  include JSON::Serializable
  include JSON::Serializable::Strict
  property collection_name : String?
  property institution_code : String?
  property latest_collection_code : Int32?
  property note : String?

  switch_avram_nothing_for_serialize_class(collection_name)
  switch_avram_nothing_for_serialize_class(institution_code)
  switch_avram_nothing_for_serialize_class(latest_collection_code)
  switch_avram_nothing_for_serialize_class(note)
end
