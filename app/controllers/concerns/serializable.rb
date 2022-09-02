module Serializable
  def serialize_item(object, status = :ok)
    json_response(ItemSerializer.new(object), status)
  end

  def serialize_merchant(object, status = :ok)
    json_response(MerchantSerializer.new(object), status)
  end
end