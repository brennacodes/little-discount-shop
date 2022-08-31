module Serializable
  def serialize_item(object, status = :ok)
    json_response(ItemSerializer.new(object), status)
  end

  def serialize_merchant(object, status = :ok)
    json_response(MerchantSerializer.new(object), status)
  end

  # Returns:
  #   The type of attribute that is being searched for.
  def find_type
    return type = "name" if params[:name]
    return type = "description" if params[:description]
    return type = "merchant_id" if params[:merchant_id]
    return type = "unit_price_max" if params[:unit_price_max]
    return type = "unit_price_min" if params[:unit_price_min]
    return type = "unit_price" if params[:unit_price]
    nil
  end

  def too_many_params
    return true if [params[:name], params[:description], params[:merchant_id], params[:unit_price], params[:unit_price_max], params[:unit_price_min]].compact.count > 1
  end
end