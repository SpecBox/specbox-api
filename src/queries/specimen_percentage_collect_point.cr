class SpecimenPercentageCollectPointQuery < Specimen::BaseQuery
  def self.all(user_id, target_collection, target_collect_point, is_all)
    allowed_collect_point_columns = [
      "contient",
      "island_group",
      "island",
      "country",
      "state_provice",
      "county",
      "municipality",
      "japanese_place_name",
      "japanese_place_name_detail",
    ]

    if allowed_collect_point_columns.includes?(target_collect_point)
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
            collect_points."#{target_collect_point}" as collect_point_name,
            count(*) as collect_point_count,
            (round((cast(count(collect_points."#{target_collect_point}") as float) / (select specimens_count from all_specimens) * 100.0)::numeric, 2))::DOUBLE PRECISION as collect_point_percentage
          from
            specimens
          inner join
            collection_settings on specimens.collection_settings_info_id = collection_settings.id
          left join
            collect_points on specimens.collect_point_info_id = collect_points.id
          where
            specimens.user_id = $1
          group by
            collect_points."#{target_collect_point}"
          order by
            collect_point_percentage desc
        SQL
        AppDatabase.query_all(
          sql,
          args: [user_id],
          as: Specimen::PercentageCollectPoint
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
            collect_points."#{target_collect_point}" as collect_point_name,
            count(*) as collect_point_count,
            (round((cast(count(collect_points."#{target_collect_point}") as float) / (select specimens_count from all_specimens) * 100.0)::numeric, 2))::DOUBLE PRECISION as collect_point_percentage
          from
            specimens
          inner join
            collection_settings on specimens.collection_settings_info_id = collection_settings.id
          left join
            collect_points on specimens.collect_point_info_id = collect_points.id
          where
            specimens.user_id = $1 and collection_settings.institution_code = $2
          group by
            collect_points."#{target_collect_point}"
          order by
            collect_point_percentage desc
        SQL
        AppDatabase.query_all(
          sql,
          args: [user_id, target_collection],
          as: Specimen::PercentageCollectPoint
        )
      else
        raise "Invalid is_all value: #{is_all}"
      end
    else
      raise "Invalid collect_point column name: #{target_collect_point}"
    end
  end
end
