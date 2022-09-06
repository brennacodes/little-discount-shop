module Typable
  def item_or_merchant
    return conditions("name") if params[:name]
    get_item_type
  end

  def get_item_type
    return "name" if item_params[:name]
    return "description" if item_params[:description]
    return "merchant_id" if item_params[:merchant_id]
    evaluate_price_params
  end

  def evaluate_price_params
    return "unit_price_max" if item_params[:unit_price_max]
    return "unit_price_min" if item_params[:unit_price_min]
    return "unit_price" if item_params[:unit_price]
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
    type = item_or_merchant
    conditions(type)
  end

  def paramalyzer
    parms = params.keys[0..-3]
    return true if parms.length > 1 && parms.include?("name") || parms.include?("description") || parms.include?("merchant_id") || parms.include?("unit_price")
    return min_max_price
  end

  def too_many_params
    params.keys[0..-3]
    false
  end
end