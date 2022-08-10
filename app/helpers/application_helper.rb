module ApplicationHelper
  include Pagy::Frontend
  
  def format_date(date)
    date.strftime("%A, %B %d, %Y")
  end

  def format_price(price)
    "$#{(price.to_f/100.00).round(2)}"
  end

  def convert_and_format_date(input)
    if input.is_a?(String)
      date = Date.strptime(input, '%Y-%m-%d').strftime("%A, %B %d, %Y")
    elsif input.is_a?(Date)
      input.strftime("%A, %B %d, %Y")
    else
      "N/A"
    end
  end

  def convert_date(input)
    Date.strptime(input, '%Y-%m-%d')
  end
end
