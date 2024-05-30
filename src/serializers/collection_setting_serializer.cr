class CollectionSettingSerializer < BaseSerializer
  def initialize(@collection_setting : CollectionSetting)
  end

  def render
    {
      id: @collection_setting.id,
      created_at: @collection_setting.created_at,
      collection_name: @collection_setting.collection_name,
      institution_code: @collection_setting.institution_code,
      latest_collection_code: @collection_setting.latest_collection_code,
      note: @collection_setting.note
    }
  end
end
