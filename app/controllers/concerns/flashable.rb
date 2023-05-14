module Flashable
  def check_flash_message
    return :notice if flash[:notice]
    return :alert if flash[:alert]
    return :success if flash[:success]
    return :error if flash[:error]
    false
  end

  def has_flash_message?
    return true if check_flash_message
  end

  def flash_message
    flash[check_flash_message]
  end
end

