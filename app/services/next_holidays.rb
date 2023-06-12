class NextHolidays

  def holidays_list
    Holidays.new(service.holidays_url)
  end

  def service
    NagerService.new
  end
end