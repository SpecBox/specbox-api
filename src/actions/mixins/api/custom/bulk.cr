# バルク処理のサポート
module Api::Custom::Bulk
  def validate_params_for_bulk(params)
    params_hash = params.from_json
    params_hash["ids"]? && params_hash["data"]?
  end

  macro bulk_update(query, update_data, *allowed_columns)
    {{query}}.update(
      {% for column, index in allowed_columns %}
        {% if (index + 1) < allowed_columns.size %}
          {{column}}: {{update_data}}.{{column}}__for_avram,
        {% else %}
          {{column}}: {{update_data}}.{{column}}__for_avram
        {% end %}
      {% end %}
    )
  end
end
