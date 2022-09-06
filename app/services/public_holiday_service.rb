class PublicHolidayService
  def info
    response = conn.get
    JSON.parse(response.body, symbolize_names: true) 
  end
  
  private
    def conn
      Faraday.new("https://date.nager.at/api/v3/PublicHolidays/2022/US") do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end
end
