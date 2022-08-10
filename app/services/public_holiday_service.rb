require 'httparty'

class PublicHolidayService
  attr_reader :info

  def initialize
    @base_url = "https://date.nager.at/api/v3/PublicHolidays/2022/US"
    @info = get_info
  end

  def get_info
    response = HTTParty.get(@base_url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
