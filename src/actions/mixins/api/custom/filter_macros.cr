# フィルタリングをサポートするマクロ群
module Api::Custom::FilterMacros
  macro number_chain_filters(query, *columns)
    {% for column in columns %}
      %eq_sym = :{{column}}
      %lte_sym = :{{column}}__lte
      %gte_sym = :{{column}}__gte
      if params.get?(%eq_sym)
        if params.get(%eq_sym).to_i?
          {{query}} = {{query}}.{{column}}.eq(params.get(%eq_sym))
        end
      end
      if params.get?(%lte_sym)
        if params.get(%lte_sym).to_i?
          {{query}} = {{query}}.{{column}}.lte(params.get(%lte_sym))
        end
      end
      if params.get?(%gte_sym)
        if params.get(%gte_sym).to_i?
          {{query}} = {{query}}.{{column}}.gte(params.get(%gte_sym))
        end
      end
    {% end %}
  end

  macro string_chain_filters(query, *columns)
    {% for column in columns %}
      %eq_sym = :{{column}}
      %icontains_sym = :{{column}}__icontains
      if params.get?(%eq_sym)
        {{query}} = {{query}}.{{column}}.eq(params.get(%eq_sym))
      end
      if params.get?(%icontains_sym)
        {{query}} = {{query}}.{{column}}.ilike("%#{params.get(%icontains_sym)}%")
      end
    {% end %}
  end

  macro datetime_chain_filters(query, *columns)
    {% for column in columns %}
      %eq_sym = :{{column}}
      if params.get?(%eq_sym)
        {{query}} = {{query}}.{{column}}.as_date.eq(params.get(%eq_sym))
      end
    {% end %}
  end

  macro geo_point_chain_filters(query, *columns)
    {% for column in columns %}
      %longitude_eq_sym = :{{column}}__longitude
      %latitude_eq_sym = :{{column}}__latitude
      %longitude_lte_sym = :{{column}}__longitude_lte
      %longitude_gte_sym = :{{column}}__longitude_gte
      %latitude_lte_sym = :{{column}}__latitude_lte
      %latitude_gte_sym = :{{column}}__latitude_gte
      if params.get?(%longitude_eq_sym)
        if params.get(%longitude_eq_sym).to_f?
          {{query}} = {{query}}.{{column}}.x.eq(params.get(%longitude_eq_sym))
        end
      end
      if params.get?(%latitude_eq_sym)
        if params.get(%latitude_eq_sym).to_f?
          {{query}} = {{query}}.{{column}}.y.eq(params.get(%latitude_eq_sym))
        end
      end
      if params.get?(%longitude_lte_sym)
        if params.get(%longitude_lte_sym).to_f?
          {{query}} = {{query}}.{{column}}.x.lte(params.get(%longitude_lte_sym))
        end
      end
      if params.get?(%longitude_gte_sym)
        if params.get(%longitude_gte_sym).to_f?
          {{query}} = {{query}}.{{column}}.x.gte(params.get(%longitude_gte_sym))
        end
      end
      if params.get?(%latitude_lte_sym)
        if params.get(%latitude_lte_sym).to_f?
          {{query}} = {{query}}.{{column}}.y.lte(params.get(%latitude_lte_sym))
        end
      end
      if params.get?(%latitude_gte_sym)
        if params.get(%latitude_gte_sym).to_f?
          {{query}} = {{query}}.{{column}}.y.gte(params.get(%latitude_gte_sym))
        end
      end
    {% end %}
  end

  macro geo_point_distance_filters(query, *columns)
    %distance_longitude_sym = :__distance_longitude
    %distance_latitude_sym = :__distance_latitude
    %distance_radius_gte_sym = :__distance_radius_gte
    %distance_radius_lte_sym = :__distance_radius_lte
    {% for column in columns %}
      if params.get?(%distance_longitude_sym) && params.get?(%distance_latitude_sym) && params.get?(%distance_radius_lte_sym)
        {{query}} = {{query}}.{{column}}.distance(params.get(%distance_latitude_sym), params.get(%distance_latitude_sym)).lte(params.get(%distance_radius_lte_sym))
      end
      if params.get?(%distance_longitude_sym) && params.get?(%distance_latitude_sym) && params.get?(%distance_radius_gte_sym)
        {{query}} = {{query}}.{{column}}.distance(params.get(%distance_latitude_sym), params.get(%distance_latitude_sym)).gte(params.get(%distance_radius_gte_sym))
      end
    {% end %}
  end

  macro ordering_single_column_query(query, ordering_sym, default_column, *allowed_columns)
    if params.get?({{ordering_sym}})
      %ordering = params.get({{ordering_sym}})
      %desc = %ordering[0] == '-'
      %order_column = %ordering[0] == '-' ? %ordering.lchop : %ordering
      {% for column in allowed_columns %}
        if %order_column == "{{column}}"
          if %desc
            {{query}} = {{query}}.{{column}}.desc_order
          else
            {{query}} = {{query}}.{{column}}.asc_order
          end
        else
        end
      {% end %}
    else
      {{query}} = {{query}}.{{default_column}}.asc_order
    end
  end
end
