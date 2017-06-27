require_relative 'date_extensions'
require_relative 'time_extensions'

Date.prepend BusinessTimeMultical::TimeExtensions
Date.prepend BusinessTimeMultical::DateExtensions

# hook into Integer so we can say things like:
#  7.business_days('EURUSD').ago
#  3.business_days('EUR', 'USD').after(some_date)
#  3.business_days(['EUR', 'USD']).after(some_date)
class Integer
  def business_days(*calendars)
    BusinessTime::BusinessDays.new(self, *calendars)
  end
  alias business_day business_days
end

Time.prepend BusinessTimeMultical::TimeExtensions
Time.extend BusinessTimeMultical::TimeExtensions::ClassMethods

ActiveSupport::TimeWithZone.prepend BusinessTimeMultical::TimeExtensions
ActiveSupport::TimeWithZone.extend \
  BusinessTimeMultical::TimeExtensions::ClassMethods
