module Typable
  def find_type
    return "name" if params[:name] || item_params[:name]
    return "description" if params[:description] || item_params[:description]
    return "merchant_id" if params[:merchant_id] || item_params[:merchant_id]
    return "unit_price_max" if params[:unit_price_max] || item_params[:unit_price_max]
    return "unit_price_min" if params[:unit_price_min] || item_params[:unit_price_min]
    return "unit_price" if params[:unit_price] || item_params[:unit_price]
    return "error"
  end

  def not_nil(value)
    value != nil
  end

  def name_conds
    value = params[:name] || params[:item][:name]
    { "name" => (not_nil(value) && (value =~ /\D/ ) != nil) }
  end

  def description_conds
    value = params[:description] || params[:item][:description]
    { "description" => not_nil(value) }
  end

  def merchant_conds
    value = params[:merchant_id] || params[:item][:merchant_id]
    { "merchant_id" => (not_nil(value) && value.to_i.is_a?(Integer)) }
  end

  def price_conds(type)
    value = params[type.to_sym].to_f || params[:item][type.to_sym].to_f
    { type => (value.is_a?(Float) || value.is_a?(Integer)) && not_nil(value) }
  end

  def conditions(type)
    return name_conds if type == "name"
    return description_conds if type == "description"
    return merchant_conds if type == "merchant_id"
    return price_conds(type) if type.include?("unit_price")
    return { "error" => false }
  end

  def check_input
    type = find_type
    conditions(type)
  end

  def too_many_params
    return true if [params[:name], params[:description], params[:merchant_id], params[:unit_price], params[:unit_price_max], params[:unit_price_min]].compact.count > 1
    false
  end
end