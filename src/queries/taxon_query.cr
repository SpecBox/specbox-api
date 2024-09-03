class TaxonQuery < Taxon::BaseQuery
  def only_default_taxon
    join(
      Avram::Join::Inner.new(
        from: :all_taxa,
        to: :default_taxa,
        foreign_key: :taxon_ptr_id,
        primary_key: :id
      )
    )
  end
end
