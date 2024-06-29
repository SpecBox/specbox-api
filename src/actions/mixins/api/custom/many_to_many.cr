module Api::Custom::ManyToMany
  macro many_to_many(param_key, related_ids_key, id, id_column, related_id_column, related_id_type, association_query, association_operation)
    if params.from_json[{{param_key}}].as_h.has_key?({{related_ids_key}})
      %related_ids = params.from_json[{{param_key}}][{{related_ids_key}}].as_a.map { |{{related_id_column}}| {{related_id_type}}.new({{related_id_column}}.as_s)}
      %related_ids.each do |{{related_id_column}}|
        if {{association_query}}.new.{{id_column}}({{id}}).{{related_id_column}}({{related_id_column}}).none?
          {{association_operation}}.create!({{id_column}}: {{id}}, {{related_id_column}}: {{related_id_column}})
        end
      end
    end
  end

  macro many_to_many_for_bulk(related_ids_key, id, id_column, related_id_column, related_id_type, association_query, association_operation)
    if params.from_json["data"].as_h.has_key?({{related_ids_key}})
      %related_ids = params.from_json["data"][{{related_ids_key}}].as_a.map { |{{related_id_column}}| {{related_id_type}}.new({{related_id_column}}.as_s)}
      %related_ids.each do |{{related_id_column}}|
        if {{association_query}}.new.{{id_column}}({{id}}).{{related_id_column}}({{related_id_column}}).none?
          {{association_operation}}.create!({{id_column}}: {{id}}, {{related_id_column}}: {{related_id_column}})
        end
      end
    end
  end
end
