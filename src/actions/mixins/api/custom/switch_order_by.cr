module Api::Custom::SwitchOrder
  def switch_order(query, params)
    if params.get?(:order)
      return query.desc_order if params.get(:order) == "DESC"
    end
    query.asc_order
  end
end
