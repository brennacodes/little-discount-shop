require 'public_holiday_service'
require 'date'

class PublicHolidaySearch
  attr_reader :name, :date, :next_three_holidays

  def initialize
    @service = PublicHolidayService.new
    @next_three_holidays = next_three_holidays
  end

  def convert_date(input)
    Date.strptime(input, '%Y-%m-%d')
  end

  def next_three_holidays
    @service.info.select { |k, _v| convert_date(k[:date]) > Date.today }.take(3)
  end

  # def next_three_holidays_names
  #   @next_three_holidays.map { |holiday| holiday[:name] }
  # end

  # def next_three_holidays_dates
  #   @next_three_holidays.map { |holiday| holiday[:date] }
  # end
end