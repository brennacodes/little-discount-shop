class ItemSerializer
  include JSONAPI::Serializer
  attributes :name,
             :description,
             :unit_price,
             :merchant_id

  def merchant_id
    merchant_id.to_i
  end
             
  def unit_price
    unit_price.to_f / 100
  end
end
