class Holidays
  attr_reader :holiday_1, :holiday_2, :holiday_3

  def initialize(data)
    @holiday_1 = [data[1][:name], [data[1][:date]]]
    @holiday_2 = [data[2][:name], [data[2][:date]]]
    @holiday_3 = [data[3][:name], [data[3][:date]]]
  end
end