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

  def only_custom_taxon
    join(
      Avram::Join::Inner.new(
        from: :all_taxa,
        to: :custom_taxa,
        foreign_key: :taxon_ptr_id,
        primary_key: :id
      )
    )
  end

  def only_current_user(user_id)
    where("custom_taxa.user_id = ?", user_id)
  end
end
