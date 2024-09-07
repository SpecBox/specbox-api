class SpecimenQuery < Specimen::BaseQuery
  def all_preload
    preload_custom_taxon_info.preload_default_taxon_info.preload_collection_settings_info.preload_collect_point_info.preload_tour
  end

  def with_all_taxa
    multi_left = Avram::Join::MultiLeft.new(
      from: :specimens,
      to: :all_taxa,
      foreign_key: :id)
    multi_left.set_from_keys(from_keys: [:custom_taxon_info_id, :default_taxon_info_id])
    join(multi_left)
  end
end
