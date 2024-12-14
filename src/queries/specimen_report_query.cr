class SpecimenPercentageTaxonQuery < Specimen::BaseQuery
  def self.all(user_id, target_collection, target_taxon, is_all)
    allowed_taxon_columns = ["kingdom", "phylum", "class_name", "order",
                             "suborder", "family", "subfamily", "tribe",
                             "subtribe", "genus"]

    if allowed_taxon_columns.includes?(target_taxon)
      if is_all == "true"
        sql = <<-SQL
          with all_specimens as (
            select
              cast(count(*) as float) as specimens_count
            from
              specimens
            where
              specimens.user_id = $1
          )

          select
            all_taxa."#{target_taxon}" as taxon_name,
            count(*) as taxon_count,
            (round((cast(count(all_taxa."#{target_taxon}") as float) / (select specimens_count from all_specimens) * 100.0)::numeric, 2))::DOUBLE PRECISION as taxon_percentage
          from
            specimens
          inner join
            collection_settings on specimens.collection_settings_info_id = collection_settings.id
          left join
            all_taxa on coalesce(specimens.custom_taxon_info_id, specimens.default_taxon_info_id) = all_taxa.id
          where
            specimens.user_id = $1
          group by
            all_taxa."#{target_taxon}"
          order by
            taxon_percentage desc
        SQL
        AppDatabase.query_all(
          sql,
          args: [user_id],
          as: Specimen::PercentageTaxon
        )
      elsif is_all = "false"
        unless target_collection
          raise "Invalid target_collection! If is_all is false, target_collection must be not null!"
        end
        sql = <<-SQL
          with all_specimens as (
            select
              cast(count(*) as float) as specimens_count
            from
              specimens
            inner join
              collection_settings on specimens.collection_settings_info_id = collection_settings.id
            where
              specimens.user_id = $1 and collection_settings.institution_code = $2
          )

          select
            all_taxa."#{target_taxon}" as taxon_name,
            count(*) as taxon_count,
            (round((cast(count(all_taxa."#{target_taxon}") as float) / (select specimens_count from all_specimens) * 100.0)::numeric, 2))::DOUBLE PRECISION as taxon_percentage
          from
            specimens
          inner join
            collection_settings on specimens.collection_settings_info_id = collection_settings.id
          left join
            all_taxa on coalesce(specimens.custom_taxon_info_id, specimens.default_taxon_info_id) = all_taxa.id
          where
            specimens.user_id = $1 and collection_settings.institution_code = $2
          group by
            all_taxa."#{target_taxon}"
          order by
            taxon_percentage desc
        SQL
        AppDatabase.query_all(
          sql,
          args: [user_id, target_collection],
          as: Specimen::PercentageTaxon
        )
      else
        raise "Invalid is_all value: #{is_all}"
      end
    else
      raise "Invalid taxon column name: #{target_taxon}"
    end
  end
end
