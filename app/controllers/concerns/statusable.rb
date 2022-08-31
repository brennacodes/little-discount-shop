module Statusable
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def json_not_found(type, input)
    json_response({ errors: "Could not find object with a name matching #{input}." }, :not_found) if type == "name"
    json_response({ errors: "Could not find object with an id matching #{input}." }, :not_found) if type == "id"
    json_response({ errors: "Could not find object with a description matching #{input}." }, :not_found) if type == "description"
    json_response({ errors: "Could not find object with a merchant_id matching #{input}." }, :not_found) if type == "merchant_id"
    json_response({ errors: "Could not find object with a unit_price matching #{input}." }, :not_found) if type == "unit_price"
    json_response({ errors: "Could not find object with a unit_price over #{input}." }, :not_found) if type == "unit_price_min"
    json_response({ errors: "Could not find object with a unit_price under #{input}." }, :not_found) if type == "unit_price_max"
  end

  def json_missing_input
    json_response({ errors: "Please enter a valid search parameter and try again." }, :bad_request)
  end
end