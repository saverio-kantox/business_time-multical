require 'business_time'
require 'business_time_multical/business_days'
require 'business_time_multical/config'
require 'business_time_multical/core_ext'

# Support multicalendar holiday calculations
module BusinessTimeMultical
  def self.with(names)
    return unless block_given?
    return yield if names.empty?
    holidays = \
      BusinessTime::Config.calendars[names] +
      BusinessTime::Config.calendars[BusinessTime::Config.core_calendars]
    BusinessTime::Config.with(holidays: holidays) { yield }
  end
end
